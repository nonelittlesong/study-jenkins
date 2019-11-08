# [使用 bind mounts](https://docs.docker.com/storage/bind-mounts/)

不同点：  
使用 `-v, --volume` 去 `bind-mount` 不存在的文件或目录，总会自动生成不存在的**目录**。  
使用 `--mount` 去 `bind-mount` 不存在的文件或目录，会报错。  

## 创建 container 时用 bind mount
```sh
docker run -d \
-it \
--name devtest \
--mount type=bind,source="$(pwd)"/target,target=/app \
nginx:latest
```
```sh
docker run -d \
-it
--name devtest \
-v "$(pwd)"/target:/app \
nginx:latest
```

## 挂载到容器的非空目录
原内容会被隐藏：  
```sh
docker run -d \
  -it \
  --name broken-container \
  --mount type=bind,source=/tmp,target=/usr \
  nginx:latest

docker: Error response from daemon: oci runtime error: container_linux.go:262:
starting container process caused "exec: \"nginx\": executable file not found in $PATH".
```
```sh
docker run -d \
  -it \
  --name broken-container \
  -v /tmp:/usr \
  nginx:latest

docker: Error response from daemon: oci runtime error: container_linux.go:262:
starting container process caused "exec: \"nginx\": executable file not found in $PATH".
```

## 只读的 bind mount
```sh
docker run -d \
  -it \
  --name devtest \
  --mount type=bind,source="$(pwd)"/target,target=/app,readonly \
  nginx:latest
```
```sh
docker run -d \
  -it \
  --name devtest \
  -v "$(pwd)"/target:/app:ro \
  nginx:latest
```
