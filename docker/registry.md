## 命名
- `docker pull ubuntu` - 从官网拉取镜像。`docker pull docker.io/library/ubuntu` 的简写。  
- `docker pull myregistrydomain:port/foo/bar` - 从 `myregistrydomain:port` 拉取镜像 `foo/bar`。  

## 部署
```
$ docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
