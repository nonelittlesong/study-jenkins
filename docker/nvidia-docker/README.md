# Nvidia Docker

- [nvidia-docker github](https://github.com/NVIDIA/nvidia-docker)  
- [New Docker CLI API Support for NVIDIA GPUs under Docker Engine 19.03.0 Pre-Release](http://collabnix.com/introducing-new-docker-cli-api-support-for-nvidia-gpus-under-docker-engine-19-03-0-beta-release/)

## 安装 GPU 支持
安装 Nvidia 驱动和支持的 Docker（>19.03支持GPU）。  

添加 [repository](https://nvidia.github.io/nvidia-docker/)。  

安装 `nvidia-container-toolkit`：  
```sh
$ sudo apt-get install -y nvidia-container-toolkit
## $ sudo yum install -y nvidia-container-toolkit
```

>运行 CUDA 容器只要 NVIDIA 驱动，不必安装 CUDA 套件。  

重启 `sudo systemctl restart docker`。  

## [TensorRT](https://github.com/nvidia/TensorRT)

##  Troubleshooting
运行 `docker run --gpus all nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04 nvidia-smi` 时，报错：  
```diff
- docker: Error response from daemon: linux runtime spec devices: could not select device driver "" with capabilities: [[gpu]].
```
需要重启 docker。  


