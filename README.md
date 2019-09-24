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

```diff
- Error: Wrong volume permission.
```
