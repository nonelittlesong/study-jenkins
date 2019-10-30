用法： `docker build [OPTIONS] PATH | URL | -`  

- `-t, --tag list` - 以 `name:tag` 格式的名字和可选标签。  
- `-f, --file string` - 指定 Dockerfile。  

在守护进程运行 Dockerfile 的指令前，会先检查语法。  

每条指令是独立的，所以 `RUN cd /temp` 对下一条指令无效。  

## [BuildKit](https://github.com/moby/buildkit)
在调用 `docker build` 之前，设置环境变量：  
```
DOCKER_BUILDKIT=1
```
