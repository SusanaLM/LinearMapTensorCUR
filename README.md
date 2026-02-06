# Tensor CUR Decomposition under the Linear-Map-Based Tensor-Tensor Multiplication
<p align="center"><a href=""><img src='https://img.shields.io/badge/arXiv-Paper-red?logo=arxiv&logoColor=white' alt='arXiv'></a>

This repository contains the code of the paper "Tensor CUR Decomposition under the Linear-Map-Based Tensor-Tensor Multiplication"

## Contents

* **Overview**
  
We introduce the tensor CUR decomposition under the framework of the linear-map-based tensor-tensor multiplication, and show its performance in video foreground-background separation for different linear maps.

* **Full Table 1**

Table 1 of comparison of the tensor CUR decomposition with different matrices. Evaluating metrics are Relative error (RE), AGE, pEPs, pCEPs, PSNR, MS-SSIM and CPU time.
The comparison was done on the CAVIAR1 sequence of shape [256, 384, 610], the HumanBody2 video sequence of shape [320, 240, 740], the IBMtest2 video sequence of shape [320, 240, 90] and the HighwayII video sequence of shape [320, 240, 500] available at this [link](https://sbmi2015.na.icar.cnr.it/SBIdataset.html).

| Sequence | Method | RE | AGE | pEPs | pCEPs | PSNR | MS-SSIM | CPU Time(s) |
|----------|--------|----|-----|------|-------|------|---------|-------------|
| CAVIAR1 | DCT inj | 0.09754 | 12.4722 | 0.11329 | 0.06111 | 24.83 | 0.9794 | 33.8250 |
| CAVIAR1 | DCT inv | 0.09687 | 12.4689 | 0.11289 | 0.05854 | 24.84 | 0.9788 | 28.9215 |
| CAVIAR1 | DCT surj | 0.09844 | 12.4575 | 0.10918 | 0.05942 | 24.85 | 0.9805 | 22.9467 |
| CAVIAR1 | DFT inj | 0.09834 | 12.2623 | 0.10099 | 0.05625 | 24.98 | 0.9818 | 62.0009 |
| CAVIAR1 | DFT inv | 0.09750 | 12.1580 | 0.09814 | 0.05404 | 25.05 | 0.9818 | 43.2913 |
| CAVIAR1 | DFT surj | 0.09819 | 12.2093 | 0.09992 | 0.05572 | 25.01 | 0.9818 | 25.4176 |
| CAVIAR1 | DST inj | 0.09788 | 12.4786 | 0.11229 | 0.06010 | 24.84 | 0.9797 | 36.3511 |
| CAVIAR1 | DST inv | 0.09697 | 12.3870 | 0.11089 | 0.05753 | 24.88 | 0.9790 | 27.8742 |
| CAVIAR1 | DST surj | 0.09851 | 12.3842 | 0.10828 | 0.05908 | 24.89 | 0.9804 | 24.3135 |
| CAVIAR1 | U_3 inj | 0.09644 | 12.4056 | 0.11210 | 0.05806 | 24.86 | 0.9786 | 39.5282 |
| CAVIAR1 | U_3 inv | 0.09644 | 12.4056 | 0.11210 | 0.05806 | 24.86 | 0.9786 | 34.1751 |
| CAVIAR1 | U_3 surj | 0.09780 | 12.3944 | 0.11064 | 0.06069 | 24.85 | 0.9792 | 27.9369 |
| HumanBody2 | DCT inj | 0.04884 | 4.9094 | 0.00676 | 0.00052 | 31.70 | 0.9946 | 31.1496 |
| HumanBody2 | DCT inv | 0.04636 | 5.0693 | 0.00757 | 0.00068 | 31.43 | 0.9940 | 25.3175 |
| HumanBody2 | DCT surj | 0.05679 | 4.6329 | 0.00608 | 0.00048 | 32.09 | 0.9952 | 18.5515 |
| HumanBody2 | DFT inj | 0.05376 | 4.6058 | 0.00591 | 0.00045 | 32.13 | 0.9953 | 65.1296 |
| HumanBody2 | DFT inv | 0.05182 | 4.5436 | 0.00582 | 0.00044 | 32.21 | 0.9952 | 45.5084 |
| HumanBody2 | DFT surj | 0.05588 | 4.6986 | 0.00597 | 0.00044 | 32.00 | 0.9952 | 22.8086 |
| HumanBody2 | DST inj | 0.04933 | 4.9303 | 0.00684 | 0.00054 | 31.66 | 0.9946 | 28.6135 |
| HumanBody2 | DST inv | 0.04701 | 5.1030 | 0.00766 | 0.00070 | 31.36 | 0.9939 | 23.9500 |
| HumanBody2 | DST surj | 0.05489 | 4.8380 | 0.00646 | 0.00054 | 31.76 | 0.9949 | 18.4911 |
| HumanBody2 | U_3 inj | 0.04638 | 5.0501 | 0.00912 | 0.00080 | 31.31 | 0.9938 | 35.9131 |
| HumanBody2 | U_3 inv | 0.04638 | 5.0501 | 0.00912 | 0.00080 | 31.31 | 0.9938 | 30.6677 |
| HumanBody2 | U_3 surj | 0.05677 | 5.5033 | 0.00776 | 0.00060 | 30.88 | 0.9946 | 23.3408 |
| IBMtest2 | DCT inj | 0.03500 | 3.9799 | 0.00193 | 0.00001 | 33.93 | 0.9927 | 3.2343 |
| IBMtest2 | DCT inv | 0.03091 | 4.2296 | 0.00216 | 0.00001 | 33.51 | 0.9917 | 3.1121 |
| IBMtest2 | DCT surj | 0.04037 | 3.4767 | 0.00101 | 0.00000 | 35.21 | 0.9940 | 2.3422 |
| IBMtest2 | DFT inj | 0.04267 | 3.0102 | 0.00082 | 0.00000 | 36.24 | 0.9948 | 5.6617 |
| IBMtest2 | DFT inv | 0.04158 | 3.0503 | 0.00090 | 0.00000 | 36.15 | 0.9948 | 5.1998 |
| IBMtest2 | DFT surj | 0.04386 | 2.9598 | 0.00082 | 0.00000 | 36.35 | 0.9949 | 2.9217 |
| IBMtest2 | DST inj | 0.03708 | 3.7869 | 0.00173 | 0.00001 | 34.29 | 0.9928 | 3.2613 |
| IBMtest2 | DST inv | 0.03239 | 3.9689 | 0.00179 | 0.00000 | 33.90 | 0.9919 | 3.1296 |
| IBMtest2 | DST surj | 0.04153 | 3.3238 | 0.00113 | 0.00000 | 35.35 | 0.9938 | 2.3454 |
| IBMtest2 | U_3 inj | 0.03148 | 4.1431 | 0.00228 | 0.00001 | 33.61 | 0.9918 | 3.9778 |
| IBMtest2 | U_3 inv | 0.03148 | 4.1431 | 0.00228 | 0.00001 | 33.61 | 0.9918 | 3.8065 |
| IBMtest2 | U_3 surj | 0.04097 | 3.4828 | 0.00168 | 0.00001 | 34.90 | 0.9936 | 3.0276 |
| HighwayII | DCT inj | 0.04447 | 3.7273 | 0.00486 | 0.00002 | 32.08 | 0.9882 | 18.1010 |
| HighwayII | DCT inv | 0.04383 | 3.7292 | 0.00492 | 0.00002 | 32.06 | 0.9878 | 15.5463 |
| HighwayII | DCT surj | 0.04488 | 3.7010 | 0.00479 | 0.00002 | 32.11 | 0.9883 | 12.9759 |
| HighwayII | DFT inj | 0.04467 | 3.6576 | 0.00468 | 0.00001 | 32.16 | 0.9886 | 33.0854 |
| HighwayII | DFT inv | 0.04494 | 3.7286 | 0.00472 | 0.00001 | 32.10 | 0.9885 | 25.0802 |
| HighwayII | DFT surj | 0.04474 | 3.6368 | 0.00471 | 0.00001 | 32.18 | 0.9886 | 15.7110 |
| HighwayII | DST inj | 0.04442 | 3.7004 | 0.00483 | 0.00002 | 32.08 | 0.9882 | 17.9737 |
| HighwayII | DST inv | 0.04391 | 3.7291 | 0.00488 | 0.00002 | 32.07 | 0.9878 | 15.5677 |
| HighwayII | DST surj | 0.04498 | 3.7043 | 0.00476 | 0.00001 | 32.12 | 0.9884 | 12.5205 |
| HighwayII | U_3 inj | 0.04341 | 3.7641 | 0.00515 | 0.00002 | 32.05 | 0.9872 | 21.1446 |
| HighwayII | U_3 inv | 0.04341 | 3.7641 | 0.00515 | 0.00002 | 32.05 | 0.9872 | 18.6278 |
| HighwayII | U_3 surj | 0.04476 | 3.6997 | 0.00481 | 0.00001 | 32.16 | 0.9881 | 15.6205 |

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
