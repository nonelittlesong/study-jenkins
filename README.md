# study-jenkins
file watcher, jenkins, 

- [Jenkins Github](https://github.com/jenkinsci)
- [Jenkins](https://jenkins.io/)


## 一、 安装
### 1、 [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) 版
使用最新的 jenkins 稳定版：  
```
docker pull jenkins/jenkins:lts
```
运行，将数据目录从容器映射到主机：  
```
docker run -d -p 49001:8080 -v $PWD/jenkins:/var/jenkins_home -t jenkins/jenkins:lts
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
docker run --restart=always -d -p 49001:8080 \
-v $CONFIG_FOLDER:/var/jenkins_home:z \
# -e http_proxy='http://proxy.com:8080' \
# -e https_proxy='http://proxy.com:8080' \
--name jenkins -t jenkins
 
docker logs --follow jenkins
```

>[--restart=always](https://www.cnblogs.com/kaishirenshi/p/10396446.html): 当 Docker 重启时，容器自动启动。  

