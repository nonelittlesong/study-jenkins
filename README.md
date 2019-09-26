# study-jenkins
file watcher, jenkins, 

- [Jenkins Github](https://github.com/jenkinsci)
- [Jenkins](https://jenkins.io/)


## 一、 安装

>**注意**:  
jenkins 建议直接安装在宿主机，不用 docker 方式，因为持续集成需要安装各种我们用到的工具，这些工具可能后面根据需要才安装，重启不能让这些工具丢失。比如编译 java 源码需要装 jdk 环境，编译和上传 docker 镜像需要安装 docker 环境，并且还需要提前 docker login 好，不然上传不了。  

### 1、 [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) 版
使用最新的 jenkins 稳定版：  
```
docker pull jenkins/jenkins:lts
```
运行，将数据目录从容器映射到主机：  
```
docker run -d -p 49001:8080 -v $PWD/jenkins:/var/jenkins_home:z -t jenkins/jenkins:lts
```
- `-d` - 在后台运行
- `-p` - 端口映射。主机端口:容器端口。
- `-t` - 伪 TTY。
- `-v` - 绑定挂载数据卷。
- `-i` - 后台运行依旧保持 stdin 开启。

```diff
- Error: Wrong volume permission.
```
[解决方案](https://blog.csdn.net/babys/article/details/71170254):  

- [Installing Jenkins with Docker](https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+with+Docker)

```sh
#!/bin/bash
 
# Pull latest container
docker pull jenkins
 
# Setup local configuration folder
# Should already be in a jenkins folder when running this script.
export CONFIG_FOLDER=$PWD/config
mkdir $CONFIG_FOLDER
chown 1000 $CONFIG_FOLDER
 
# Start container
docker run --restart always -d -p 49001:8080 \
-v $CONFIG_FOLDER:/var/jenkins_home:z \
# -e http_proxy='http://proxy.com:8080' \
# -e https_proxy='http://proxy.com:8080' \
--name jenkins -t jenkins
 
docker logs --follow jenkins
```

>[--restart always](https://www.cnblogs.com/kaishirenshi/p/10396446.html): 当 Docker 重启时，容器自动启动。  
>在后面加上 `/bin/bash` 无法正常启动 jenkins。  


### 2、 .war 版


## 二、 Troubleshooting
### Tag Push Hook 无效
原因是：  
`Tag Push Hook` 传给 jenkins 的 branch 是 `refs/tags/v1.0.1`，与允许的 branches 不一致。  
解决方案：  
<kbd>freestyle project</kbd> -> <kbd>Build Triggers</kbd> -> <kbd>Allowed branches</kbd>  
设置为 Allow all branches to trigger this job。  

