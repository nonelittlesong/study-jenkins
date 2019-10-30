# Nvidia Docker

- [nvidia-docker github](https://github.com/NVIDIA/nvidia-docker)  

## 安装 GPU 支持
安装 Nvidia 驱动和支持的 Docker（>19.03支持GPU）。  

添加 [repository](https://nvidia.github.io/nvidia-docker/)。  

安装 `nvidia-container-toolkit`：  
```sh
$ sudo apt-get install -y nvidia-container-toolkit
## $ sudo yum install -y nvidia-container-toolkit
```

>运行 CUDA 容器只要 NVIDIA 驱动，不必安装 CUDA 套件。  

