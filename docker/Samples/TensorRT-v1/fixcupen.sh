#!/bin/bash
#
# song@20191101
#

## 替换 FindCUDA.cmake 中的
## unset(CUDA_nppi_LIBRARY CACHE)
CUDA_NPPI='unset(CUDA_nppial_LIBRARY CACHE)\n  unset(CUDA_nppicc_LIBRARY CACHE)\n  unset(CUDA_nppicom_LIBRARY CACHE)\n  unset(CUDA_nppidei_LIBRARY CACHE)\n  unset(CUDA_nppif_LIBRARY CACHE)\n  unset(CUDA_nppig_LIBRARY CACHE)\n  unset(CUDA_nppim_LIBRARY CACHE)\n  unset(CUDA_nppist_LIBRARY CACHE)\n  unset(CUDA_nppisu_LIBRARY CACHE)\n  unset(CUDA_nppitc_LIBRARY CACHE)'

## 替换 FindCUDA.cmake 中的
## find_cuda_helper_libs(nppi)
FIND_NPPI='find_cuda_helper_libs(nppial)\n  find_cuda_helper_libs(nppicc)\n  find_cuda_helper_libs(nppicom)\n  find_cuda_helper_libs(nppidei)\n  find_cuda_helper_libs(nppif)\n  find_cuda_helper_libs(nppig)\n  find_cuda_helper_libs(nppim)\n  find_cuda_helper_libs(nppist)\n  find_cuda_helper_libs(nppisu)\n  find_cuda_helper_libs(nppitc)'

## 替换 FindCUDA.cmake 中的
## set(CUDA_npp_LIBRARY "${CUDA_nppc_LIBRARY};${CUDA_nppi_LIBRARY};${CUDA_npps_LIBRARY}")
SET_NPPI='set(CUDA_npp_LIBRARY "${CUDA_nppc_LIBRARY};${CUDA_nppial_LIBRARY};${CUDA_nppicc_LIBRARY};${CUDA_nppicom_LIBRARY};${CUDA_nppidei_LIBRARY};${CUDA_nppif_LIBRARY};${CUDA_nppig_LIBRARY};${CUDA_nppim_LIBRARY};${CUDA_nppist_LIBRARY};${CUDA_nppisu_LIBRARY};${CUDA_nppitc_LIBRARY};${CUDA_npps_LIBRARY}")'

## 替换 OpenCVDetectCUDA.cmake 中的
## set(__cuda_arch_bin "2.0 2.1(2.0)")
## set(__cuda_arch_bin "2.0 2.1(2.0) 3.0 3.5")
CUDA_ARCH='set(__cuda_arch_bin "3.0 3.5")'

sed -i "s/unset(CUDA_nppi_LIBRARY CACHE)/${CUDA_NPPI}/" /root/opencv-2.4.13/cmake/FindCUDA.cmake
sed -i "s/find_cuda_helper_libs(nppi)/${FIND_NPPI}/" /root/opencv-2.4.13/cmake/FindCUDA.cmake
sed -i "s/set(CUDA_npp_LIBRARY \"\${CUDA_nppc_LIBRARY};\${CUDA_nppi_LIBRARY};\${CUDA_npps_LIBRARY}\")/${SET_NPPI}/" /root/opencv-2.4.13/cmake/FindCUDA.cmake
sed -i "s/set(__cuda_arch_bin \"2.0 2.1(2.0)\")/${CUDA_ARCH}/" /root/opencv-2.4.13/cmake/OpenCVDetectCUDA.cmake
sed -i "s/set(__cuda_arch_bin \"2.0 2.1(2.0) 3.0 3.5\")/${CUDA_ARCH}/" /root/opencv-2.4.13/cmake/OpenCVDetectCUDA.cmake

