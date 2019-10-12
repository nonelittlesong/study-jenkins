## 命名
- `docker pull ubuntu` - 从官网拉取镜像。`docker pull docker.io/library/ubuntu` 的简写。  
- `docker pull myregistrydomain:port/foo/bar` - 从 `myregistrydomain:port` 拉取镜像 `foo/bar`。  

## 部署
```
$ docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

基础配置：  
```
$ docker run -d \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:5001 \  # 配置端口
  -p 5001:5001 \
  --name registry-test \
  -v /mnt/registry:/var/lib/registry \  # 定义数据卷
  registry:2
```

### 外部访问
- [局域网内部署 Docker Registry](https://yq.aliyun.com/articles/373068)

**编辑 `/etc/ssl/openssl.cnf`**  
```
subjectAltName=IP:10.205.56.200
```
**创建自签名证书**  
```sh
$ mkdir -p certs
$ openssl req \
-newkey rsa:4096 -nodes -sha256 \
-keyout certs/domain.key \
-x509 -days 356 \
-out certs/domain.crt
```
**运行 registry**  
```sh
$ docker container stop registry
$ docker container rm registry

$ docker run -d \
--restart=always \
--name registry \
-v "$(pwd)"/certs:/certs \
-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
-e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
-p 443:443 \
registry:2
```
**在 client 端设置根证书**  
把 `certs/domain.crt` 复制到需要访问 registry 的主机上。  
```sh
# 在需要访问 registry 服务器的客户端创建保存证书的目录
$ sudo mkdir -p /etc/docker/certs.d/10.205.56.200:443
# 复制证书到该目录
# 重命名证书为 ca.crt
# 重启 docker
```
