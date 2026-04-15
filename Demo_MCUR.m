function results = Demo_MCUR(varargin)
% Demo_MCUR
% This demo reproduces the implementation of the proposed tensor *M-CUR on
% the carvid grayscale video tensor.
% Authors: Susana Lopez-Moreno, June-Ho Lee, Taehyeong Kim.

opts = parse_inputs_local(varargin{:});
repo_root = fileparts(mfilename('fullpath'));
data_dir = fullfile(repo_root, 'data');

results = struct([]);

for idx = 1:numel(opts.datasets)
    dataset_name = opts.datasets{idx};
    dataset_path = fullfile(data_dir, dataset_name);
    D = load_tensor_from_mat_local(dataset_path);

    fprintf('Running MCUR on %s (%d x %d x %d)\n', dataset_name, size(D, 1), size(D, 2), size(D, 3));
    run_result = run_mcur_tensor_local(D, opts);

    frame_indices = sanitize_frame_indices_local(size(D, 3), opts.frame_indices);

    results(idx).dataset = dataset_name; 
    results(idx).path = dataset_path;
    results(idx).size = size(D);
    results(idx).frame_indices = frame_indices;
    results(idx).runtime_seconds = run_result.runtime_seconds;
    results(idx).relres_history = run_result.relres_history;
    results(idx).background = run_result.background;
    results(idx).foreground = run_result.foreground;
    results(idx).foreground_mask = run_result.foreground_mask;
    results(idx).original = D;

    fprintf('  finished in %.3f s, final rel-res %.3e\n', ...
        run_result.runtime_seconds, run_result.relres_history(end));
end

if opts.make_plots
    show_results_local(results);
end
end

function opts = parse_inputs_local(varargin)
parser = inputParser;
parser.FunctionName = mfilename;

default_datasets = {'gray_carvid.mat'};
default_frame_indices = [20, 40, 60, 80, 100];

addParameter(parser, 'datasets', default_datasets, @(x) iscellstr(x) || isstring(x));
addParameter(parser, 'make_plots', true, @(x) islogical(x) || isnumeric(x));
addParameter(parser, 'frame_indices', default_frame_indices, @(x) isnumeric(x) && isvector(x) && all(x >= 1));
addParameter(parser, 'r_sub', 10, @(x) isnumeric(x) && isscalar(x) && x >= 1);
addParameter(parser, 'K_low', 20, @(x) isnumeric(x) && isscalar(x) && x >= 1);
addParameter(parser, 'row_frac', 0.6, @(x) isnumeric(x) && isscalar(x) && x > 0 && x <= 1);
addParameter(parser, 'col_frac', 0.6, @(x) isnumeric(x) && isscalar(x) && x > 0 && x <= 1);
addParameter(parser, 'num_iterations', 15, @(x) isnumeric(x) && isscalar(x) && x >= 1);
addParameter(parser, 'tau_mad', 0.5, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(parser, 'tau_fg_mask', 7.5, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(parser, 'lambda_ridge', 1e-2, @(x) isnumeric(x) && isscalar(x) && x >= 0);
addParameter(parser, 'pinv_tol', 1e-6, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(parser, 'refresh_every', 1, @(x) isnumeric(x) && isscalar(x) && x >= 1);

parse(parser, varargin{:});
opts = parser.Results;
opts.datasets = cellstr(opts.datasets);
opts.make_plots = logical(opts.make_plots);
end

function D = load_tensor_from_mat_local(mat_path)
if ~isfile(mat_path)
    error('Demo_MCUR:MissingData', 'Dataset not found: %s', mat_path);
end

mat_contents = load(mat_path);
field_names = fieldnames(mat_contents);

tensor = [];
for idx = 1:numel(field_names)
    value = mat_contents.(field_names{idx});
    if isnumeric(value) && ndims(value) == 3 && all(size(value) > 1)
        tensor = value;
        break;
    end
end

if isempty(tensor)
    error('Demo_MCUR:InvalidData', 'No numeric 3-D tensor found in %s', mat_path);
end

D = double(tensor);
max_value = max(D(:));
if max_value > 1
    D = D ./ max_value;
end
end

function result = run_mcur_tensor_local(D, opts)
[m, n, p] = size(D);

B0 = median(D, 3);
D0 = D - repmat(B0, [1, 1, p]);

M = dct_matrix_local(p);
Minv = M.';

L_prop = zeros(m, n, p);
S_prop = zeros(m, n, p);
I_det = [];
J_det = [];
relres_history = zeros(opts.num_iterations, 1);

r_rows = max(20, min(m, round(opts.row_frac * m)));
c_cols = max(20, min(n, round(opts.col_frac * n)));

timer_id = tic;
for iter = 1:opts.num_iterations
    R = D0 - L_prop;
    S_prop = soft_th_mad_local(R, opts.tau_mad);

    Y = D0 - S_prop;
    Yt = mode3mul_local(Y, M);
    K_use = min(opts.K_low, size(Yt, 3));

    if isempty(I_det) || isempty(J_det) || mod(iter - 1, opts.refresh_every) == 0
        [I_det, J_det] = select_IJ_by_DEIM_band_local(Yt, opts.r_sub, r_rows, c_cols, K_use);
    end

    Lt = project_CUR_band_local(Yt, I_det, J_det, K_use, opts.lambda_ridge, opts.pinv_tol);
    L_prop = mode3mul_local(Lt, Minv);

    relres_history(iter) = norm(D0(:) - L_prop(:) - S_prop(:)) / max(norm(D0(:)), eps);
    fprintf('  iter %d/%d  rel-res=%.3e\n', iter, opts.num_iterations, relres_history(iter));
end
runtime_seconds = toc(timer_id);

background = L_prop + repmat(B0, [1, 1, p]);
foreground_raw = D - background;
[foreground, foreground_mask] = foreground_from_mask_local(foreground_raw, D, opts.tau_fg_mask);

result.background = background;
result.foreground = foreground;
result.foreground_mask = foreground_mask;
result.relres_history = relres_history;
result.runtime_seconds = runtime_seconds;
end

function show_results_local(results)
for idx = 1:numel(results)
    frame_indices = results(idx).frame_indices;
    num_cols = numel(frame_indices);

    figure('Name', sprintf('MCUR Demo - %s', results(idx).dataset), ...
        'Color', 'w', 'Position', [100, 100, 300 * num_cols, 850]);

    for col = 1:num_cols
        frame_idx = frame_indices(col);

        subplot(3, num_cols, col);
        imagesc(clamp01_local(results(idx).original(:, :, frame_idx)), [0, 1]);
        axis image off;
        colormap gray;
        title(sprintf('Frame %d', frame_idx));
        if col == 1
            ylabel('Original');
        end

        subplot(3, num_cols, col + num_cols);
        imagesc(clamp01_local(results(idx).background(:, :, frame_idx)), [0, 1]);
        axis image off;
        colormap gray;
        if col == 1
            ylabel('BG');
        end

        subplot(3, num_cols, col + 2 * num_cols);
        imagesc(clamp01_local(results(idx).foreground(:, :, frame_idx)), [0, 1]);
        axis image off;
        colormap gray;
        if col == 1
            ylabel('FG');
        end
    end

end
end

function frame_indices = sanitize_frame_indices_local(num_frames, requested_indices)
if isempty(requested_indices)
    frame_indices = max(1, round(num_frames / 2));
    return;
end

frame_indices = round(requested_indices(:).');
frame_indices = min(num_frames, max(1, frame_indices));
end

function X = clamp01_local(X)
X = max(0, min(1, X));
end

function M = dct_matrix_local(n)
M = zeros(n, n);
scale0 = sqrt(1 / n);
scale = sqrt(2 / n);

for row = 0:(n - 1)
    if row == 0
        alpha = scale0;
    else
        alpha = scale;
    end

    for col = 0:(n - 1)
        M(row + 1, col + 1) = alpha * cos((pi * (2 * col + 1) * row) / (2 * n));
    end
end
end

function Xtilde = mode3mul_local(X, Mmat)
[m, n, p] = size(X);
Xtilde = reshape(reshape(X, [], p) * Mmat.', m, n, size(Mmat, 1));
end

function [I, J] = select_IJ_by_DEIM_band_local(Yt, r_sub, r_rows, c_cols, K)
[m, n, p] = size(Yt);
K = min(K, p);
Uall = [];
Vall = [];

for k = 1:K
    Yk = Yt(:, :, k);
    r_use = max(1, min([r_sub, m, n]));
    try
        [Uk, ~, Vk] = svds(Yk, r_use, 'L');
    catch
        [Uk, ~, Vk] = svd(Yk, 'econ');
        Uk = Uk(:, 1:min(r_use, size(Uk, 2)));
        Vk = Vk(:, 1:min(r_use, size(Vk, 2)));
    end
    Uall = [Uall, Uk];
    Vall = [Vall, Vk];
end

[QU, ~] = qr(Uall, 0);
[QV, ~] = qr(Vall, 0);

sI = min(r_rows, size(QU, 2));
sJ = min(c_cols, size(QV, 2));

[~, ~, pivU] = qr(QU.', 'vector');
[~, ~, pivV] = qr(QV.', 'vector');

I = sort(pivU(1:sI));
J = sort(pivV(1:sJ));
end

function Lt = project_CUR_band_local(Yt, I, J, K, lambda_ridge, pinv_tol)
[m, n, p] = size(Yt);
Lt = zeros(m, n, p);
K = min(K, p);

for k = 1:K
    Yk = Yt(:, :, k);
    Ck = Yk(:, J);
    Rk = Yk(I, :);
    Wk = Yk(I, J);

    if lambda_ridge > 0
        Uk = (Wk' * Wk + lambda_ridge * eye(size(Wk, 2))) \ Wk';
    else
        Uk = pinv(Wk, pinv_tol);
    end

    Lt(:, :, k) = Ck * Uk * Rk;
end
end

function S = soft_th_mad_local(R, tau)
S = zeros(size(R));
for k = 1:size(R, 3)
    X = R(:, :, k);
    med = median(X(:));
    sigma = median(abs(X(:) - med)) / 0.6744898;
    th = tau * max(sigma, eps);
    S(:, :, k) = sign(X) .* max(abs(X) - th, 0);
end
end

function [F_masked, M] = foreground_from_mask_local(S_fg, D, tau)
[m, n, p] = size(S_fg);
F_masked = zeros(m, n, p);
M = false(m, n, p);

for k = 1:p
    X = S_fg(:, :, k);
    med = median(X(:));
    sigma = median(abs(X(:) - med)) / 0.6744898;
    th = tau * max(sigma, eps);
    Mk = abs(X) >= th;
    M(:, :, k) = Mk;
    F_masked(:, :, k) = D(:, :, k) .* double(Mk);
end
end
