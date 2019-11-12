```sh
docker build -t friendlyhello .                           # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyhello                          # Run "friendlyhello" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyhello                                  # Same thing, but in detached mode

docker container ls                                                          # List all running containers
docker ps                                                                    # List all running containers
docker ps -a --no-trunc                                          # Don't truncate output（查看完整的 COMMAND）
docker container ls -a                                       # List all containers, even those not running
docker container stop <hash>                                     # Gracefully stop the specified container
docker start [OPTIONS] CONTAINER [CONTAINER...]                     # Start one or more stopped containers
docker start -ai CONTAINER                                                                # 交互模式启动容器
docker container kill <hash>                                   # Force shutdown of the specified container
docker container rm <hash>                                  # Remove specified container from this machine
docker container rm $(docker container ls -a -q)                                   # Remove all containers

docker port CONTAINER [PRIVATE_PORT[/PROTO]]  # List port mappings or a specific mapping for the container
docker logs [OPTIONS] CONTAINER                                            # Fetch the logs of a container
docker top CONTAINER [ps OPTIONS]                           # Display the running processes of a container
docker inspect [OPTIONS] NAME|ID [NAME|ID...]             # Return low-level information on Docker objects

docker image ls -a                                                       # List all images on this machine
docker image rm <image id>                                      # Remove specified image from this machine
docker rmi <image id>
docker image rm $(docker image ls -a -q)                             # Remove all images from this machine
docker login                                       # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag                            # Tag <image> for upload to registry
docker push username/repository:tag                                      # Upload tagged image to registry
docker run username/repository:tag                                             # Run image from a registry
```

## docker run --help
语法： `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`  

| 选项 | 参数 | 描述 |
| --- | --- | --- |
| -P | | 将容器的所有端口映射到主机上，随机分配。 |
| -p | hostport:containerport | 端口映射。主机端口:容器端口。 |
| -d | | 在后台运行 |
| -i | | 后台运行依旧保持 stdin 开启。通常和 -t 连用。 |
| -t | | 伪 TTY。通常和 -i 连用。|
| -v | /host/volume:/container/volume | 绑定挂载数据卷。冒号左右都会创建不存在的目录。使用 $HOME 而不是 \`pwd\` |
| --rm | | 退出时自动删除容器 |
| --name | string | 设置容器名 |

- 有 `-i` 无 `-t` - 没有 伪 TTY，没有输出显示在终端。
- 无 `-i` 有 `-t` - 无法从 stdin 获取输入。

## exec & attach
### exec
Run a command in a running container  
```
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```
>必须要有 container 和 command 两个参数。

例子：  
```
docker exec -it 8f128708d691 /bin/bash
```

### attach
Attach local standard input, output, and error streams to a running container  
```
docker attach [OPTIONS] CONTAINER
```
options:  
- `--detach-keys string` - Override the key sequence for detaching a container
- `--no-stdin` - Do not attach STDIN
- `--sig-proxy` - Proxy all received signals to the process (default true)
