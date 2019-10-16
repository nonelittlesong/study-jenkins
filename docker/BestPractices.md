# 开发经验

## 让你的 images 尽可能的小
- 基于合适的 image 编写 Dockerfile。  
- 使用 [multistage builds](https://docs.docker.com/develop/develop-images/multistage-build/)。  
  - 如果不包含 multistage builds，尽量少用 `RUN` 指令。  
- 如果多个镜像有相同部分，创建 [base image](https://docs.docker.com/develop/develop-images/baseimages/)。  
- 产品 image 可调试。  
- 合适的标签。  

## 数据保存
- 用 volumes / bind mounts。  

## swarm services
- 尽可能使用 swarm services。  

## 比较开发和生产环境

| 开发 | 生产 |
| --- | --- |
| 使用 bind mounts 访问源代码 | 使用 volumes 保存数据 |

