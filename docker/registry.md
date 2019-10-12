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
$ mkdir certs
$ openssl req \
-newkey rsa:4096 -nodes -sha256 \
-keyout certs/domain.key \
-x509 -days 356 \
-out certs/domain.crt
```
