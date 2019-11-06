# Nvidia Docker

- [nvidia-docker github](https://github.com/NVIDIA/nvidia-docker)  
- [New Docker CLI API Support for NVIDIA GPUs under Docker Engine 19.03.0 Pre-Release](http://collabnix.com/introducing-new-docker-cli-api-support-for-nvidia-gpus-under-docker-engine-19-03-0-beta-release/)  
- [NVIDIA NGC](https://ngc.nvidia.com)  

## 安装 GPU 支持
安装 Nvidia 驱动和支持的 Docker（>19.03支持GPU）。  
删除旧版：  
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```
设置 repository：  
```sh
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
```
安装指定版本：  
```sh
apt-cache madison docker-ce
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
```

安装 `nvidia-container-toolkit`：  
```sh
$ sudo apt-get install -y nvidia-container-toolkit
## $ sudo yum install -y nvidia-container-toolkit
```

>运行 CUDA 容器只要 NVIDIA 驱动，不必安装 CUDA 套件。  

重启 `sudo systemctl restart docker`。  

## [TensorRT](https://github.com/nvidia/TensorRT)
- [nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04 Dockerfile](https://gitlab.com/nvidia/container-images/cuda/blob/master/dist/ubuntu16.04/9.0/devel/cudnn7/Dockerfile)  
- [nvidia/cuda dockerhub](https://hub.docker.com/r/nvidia/cuda)  
- [TensorRT NGC](https://ngc.nvidia.com/catalog/containers/nvidia:tensorrt)  
- [TensorRT 开发入门](https://www.weaf.top/posts/e0818c8b/)  
- [TensorRT DOCs](https://docs.nvidia.com/deeplearning/sdk/tensorrt-archived/index.html#trt_6)  

**查看 cuda cudnn 版本：**  
```sh
cat /usr/local/cuda/version.txt
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
## 或者
find / 'cudnn.h' # /usr/include/cudnn.h
cat /usr/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

##  Troubleshooting
运行 `docker run --gpus all nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04 nvidia-smi` 时，报错：  
```diff
- docker: Error response from daemon: linux runtime spec devices: could not select device driver "" with capabilities: [[gpu]].
```
需要重启 docker。  


