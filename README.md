# Tensor CUR Decomposition under the Linear-Map-Based Tensor-Tensor Multiplication
<p align="center"><a href=""><img src='https://img.shields.io/badge/arXiv-Paper-red?logo=arxiv&logoColor=white' alt='arXiv'></a>

This repository contains the code of the paper "Tensor CUR Decomposition under the Linear-Map-Based Tensor-Tensor Multiplication"

## Contents

* **Overview**
  
We introduce the tensor CUR decomposition under the framework of the linear-map-based tensor-tensor multiplication, and show its performance in video foreground-background separation for different linear maps.

* **Full Table 1**

Table 1 of comparison of the tensor CUR decomposition with different matrices. Evaluating metrics are Relative error (RE), F1, Precision, Recall, AGE, pEPs, PSNR and CPU time.
The comparison was done on the highway video sequence of shape [240, 320, 1231], the office video sequence of shape [240,360,1481], the pedestrians video sequence of shape [240, 360, 800] and the PETS2006 video sequence of shape [576, 720, 901] available from this [link]([https://github.com/mendozacortesgroup/Poset-filters/tree/main?tab=MIT-1-ov-file#readme](http://jacarini.dinf.usherbrooke.ca/dataset2014)).

| Sequence | Matrix M | RE	| F1	| Precision	| Recall	| AGE	| pEPs	| PSNR	| Runtime |
|--------|---------|-----|--------|---------|-----|--------|---------|-----|--------|
| highway | dct inj | 0.05336 | 0.75665 | 0.91056 | 0.64724 | 5.2899 | 0.01393 | 31.25 | 56.868 |
| highway | dct inv | **0.04790** | **0.76294** | 0.90523 | **0.65930** | **4.7693** | **0.01222** | **31.80** | 37.287 |
| highway | dct surj | 0.05711 | 0.75049 | 0.91528 | 0.63599 | 5.5036 | 0.01620 | 30.89 | 37.323 |
| highway | dft inj | 0.06014 | 0.74703 | 0.90836 | 0.63437 | 5.9753 | 0.01735 | 30.46 | 97.968 | 
| highway | dft inv | 0.05969 | 0.74798 | 0.90686 | 0.63648 | 5.9644 | 0.01697 | 30.48 | 57.039 | 
| highway | dft surj | 0.06139 | 0.74488 | 0.91238 | 0.62934 | 6.0654 | 0.01804 | 30.31 | 58.248 |
| highway | dst inj | 0.05456 | 0.75876 | 0.90795 | 0.65168 | 5.4348 | 0.01470 | 31.12 | 59.097 | 
| highway | dst inv | 0.05316 | 0.76159 | 0.90738 | 0.65616 | 5.3638 | 0.01350 | 31.24 | 37.914 | 
| highway | dst surj | 0.05647 | 0.74930 | 0.91894 | 0.63253 | 5.4307 | 0.01570 | 30.97 | 37.682 | 
| highway | u3 inj | 0.05238 | 0.75150 | 0.89916 | 0.64550 | 5.2228 | 0.01526 | 31.10 | 44.034 | 
| highway | u3 inv | 0.05238 | 0.75150 | 0.89916 | 0.64550 | 5.2228 | 0.01526 | 31.10 | 37.293 |
| highway | u3 surj | 0.06467 | 0.72966 | **0.92115** | 0.60408 | 6.2455 | 0.01911 | 30.12 | **30.364** | 
| office | dct inj | 0.03535 | 0.59432 | 0.72484 | 0.50363 | 5.2361 | 0.01964 | 28.70 | 89.706 |
| office | dct inv | **0.03262** | 0.59166 | 0.71836 | 0.50295 | **4.9732** | 0.01919 | 28.80 | 54.790 | 
| office | dct surj | 0.03900 | 0.59042 | 0.73222 | 0.49464 | 5.4987 | 0.02005 | 28.50 | 53.473 |
| office | dft inj | 0.04164 | **0.62088** | 0.73872 | **0.53547** | 5.6395 | 0.02206 | 28.32 | 155.966 | 
| office | dft inv | 0.03976 | 0.61838 | 0.74097 | 0.53059 | 5.5228 | 0.02108 | 28.41 | 80.048 | 
| office | dft surj | 0.04242 | 0.61718 | **0.74519** | 0.52671 | 5.7416 | 0.02193 | 28.30 | 80.669 | 
| office | dst inj | 0.04113 | 0.59551 | 0.73520 | 0.50043 | 5.5215 | 0.02190 | 28.65 | 85.296 |
| office | dst inv | 0.03603 | 0.59272 | 0.72617 | 0.50071 | 5.0400 | 0.02019 | **28.87** | 52.574 | 
| office | dst surj | 0.04522 | 0.59720 | 0.74348 | 0.49902 | 5.6236 | 0.02369 | 28.46 | 51.450 | 
| office | u3 inj | 0.03384 | 0.59070 | 0.71971 | 0.50091 | 5.1330 | **0.01901** | 28.81 | 66.869 |
| office | u3 inv | 0.03384 | 0.59070 | 0.71971 | 0.50091 | 5.1330 | **0.01901** | 28.81 | 53.653 | 
| office | u3 surj | 0.03470 | 0.59468 | 0.72835 | 0.50247 | 5.0147 | 0.01934 | 28.73 | **40.932** | 
| pedestrians | dct inj | 0.06201 | 0.66701 | 0.75714 | 0.59606 | 11.5279 | 0.13352 | 25.39 | 23.499 | 
| pedestrians | dct inv | 0.06223 | 0.66483 | 0.74968 | 0.59723 | 11.6279 | 0.13516 | 25.37 | 18.096 |
| pedestrians | dct surj | 0.06431 | **0.67120** | **0.77994** | 0.58907 | 12.1300 | 0.15875 | 25.10 | **17.590** |
| pedestrians | dft inj | **0.06095** | 0.65421 | 0.72286 | **0.59746** | **11.1894** | **0.12616** | **25.53** | 37.842 |
| pedestrians | dft inv | 0.06114 | 0.65725 | 0.73450 | 0.59470 | 11.2434 | 0.12686 | 25.50 | 25.258 | 
| pedestrians | dft surj | 0.06153 | 0.65784 | 0.73544 | 0.59506 | 11.3224 | 0.13309 | 25.45 | 24.591 | 
| pedestrians | dst inj | 0.06158 | 0.66547 | 0.75443 | 0.59528 | 11.4394 | 0.12808 | 25.46 | 24.529 | 
| pedestrians | dst inv | 0.06279 | 0.66226 | 0.74320 | 0.59722 | 11.8509 | 0.13826 | 25.29 | 18.013 | 
| pedestrians | dst surj | 0.06347 | 0.66487 | 0.76188 | 0.58978 | 11.8809 | 0.15099 | 25.20 | 17.898 | 
| pedestrians | u3 inj | 0.06415 | 0.67109 | 0.77450 | 0.59205 | 12.2030 | 0.15055 | 25.13 | 26.519 | 
| pedestrians | u3 inv | 0.06415 | 0.67109 | 0.77450 | 0.59205 | 12.2030 | 0.15055 | 25.13 | 23.634 | 
| pedestrians | u3 surj | 0.06103 | 0.65472 | 0.73171 | 0.59238 | 11.1935 | 0.12676 | 25.52 | 18.046 | 
| PETS2006 | dct inj | 0.12488 | 0.73497 | 0.77623 | 0.69788 | 14.4408 | 0.31818 | 23.74 | 214.653 | 
| PETS2006 | dct inv | 0.12411 | **0.74077** | **0.79044** | 0.69697 | 14.3444 | 0.30785 | 23.81 | 165.486 | 
| PETS2006 | dct surj | 0.12483 | 0.72614 | 0.75580 | 0.69871 | 14.4511 | 0.31748 | 23.72 | 155.636 | 
| PETS2006 | dft inj | 0.12466 | 0.72142 | 0.73247 | 0.71071 | 14.4166 | 0.31717 | 23.73 | 490.092 | 
| PETS2006 | dft inv | **0.12274** | 0.72518 | 0.74280 | 0.70837 | **14.1895** | **0.29030** | **23.87** | 258.710 | 
| PETS2006 | dft surj | 0.12532 | 0.72104 | 0.73467 | 0.70791 | 14.5145 | 0.32413 | 23.69 | 233.878 | 
| PETS2006 | dst inj | 0.12371 | 0.73503 | 0.77626 | 0.69796 | 14.2841 | 0.30405 | 23.82 | 233.549 |
| PETS2006 | dst inv | 0.12392 | 0.74065 | 0.78996 | 0.69713 | 14.3203 | 0.30492 | 23.82 | 167.529 | 
| PETS2006 | dst surj | 0.12499 | 0.72434 | 0.75049 | 0.69996 | 14.4622 | 0.32021 | 23.71 | **144.777** |
| PETS2006 | u3 inj | 0.12494 | 0.73759 | 0.78281 | 0.69731 | 14.4271 | 0.31739 | 23.75 | 232.255 | 
| PETS2006 | u3 inv | 0.12494 | 0.73759 | 0.78281 | 0.69731 | 14.4271 | 0.31739 | 23.75 | 194.528 | 
| PETS2006 | u3 surj | 0.12664 | 0.72732 | 0.74403 | **0.71134** | 14.6294 | 0.34136 | 23.63 | 168.701 |


* **Colophon**
  - Credits -- code, algorithm, implementation/deployment, testing and overall direction: Susana Lopez Moreno, June-Ho Lee, Taehyeong Kim.
  - Copyright and License -- see [LICENSE](https://github.com/SusanaLM/LinearMapTensorCUR/blob/main/LICENSE) file.
  - How to contribute: submit issues.
  - This project has received funding from the National Research Foundation of Korea (NRF) grant funded by the Korea government (MSIT) (No. RS-2024-00406152, 2022R1A5A1033624, RS-2024-00342939, RS-2025-25436769).
  - References:  https://arxiv.org/abs/
 
* **Citation**

If you use this code for your research, please cite our paper:

```
@misc{linearmaptensorCUR,
  title={Tensor CUR Decomposition under the Linear-Map-Based Tensor-Tensor Multiplication}, 
      author={Susana Lopez-Moreno and June-Ho Lee and Taehyeong Kim},
      year={2026},
      eprint={2602},
      archivePrefix={arXiv},
      primaryClass={},
      url={}, 
}
```
