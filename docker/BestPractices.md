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

## 容易混淆的 Dockerfile 指令
### CMD 和 ENTRYPOINT
Dockerfile 中应该只包含一个 CMD 或 ENTRYPOINT。  
>包含多个 CMD 时，只有最后一个CMD才会生效。  
>同时包含 CMD 和 ENTRYPOINT 时， CMD 中的参数其实是 ENTRYPOINT 的参数。  

### ARG 和 ENV
- ARG 是构建时参数，通过 `docker build --build-arg arg=value` 指定。  
- ENV 是运行时参数，通过 `docker run -e var=value` 指定。  

在 Dockerfile 中也可以用 `ARG` 来给 `ENV` 赋值，例如：  
```
ARG JENKINS_HOME=/var/jenkins_home
ENV JENKINS_HOME $JENKINS_HOME

ARG JENKINS_VERSION
ENV JENKINS_VERSION ${JENKINS_VERSION:-2.121.1}
```
