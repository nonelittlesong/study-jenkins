# Best practices for writing Dockerfiles
构建高效的 images。  

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Dockerfile最佳实践](https://blog.csdn.net/nklinsirui/article/details/96113636) by CSDN

## 格式
必须以 `FROM` 开始。  
`FROM` 之前可以有一个或多个 `ARG`，用于声明 `FROM` 的参数。  

只有以 `#` 开头的行会被视为注释。  

层按改动由少到多排列：  
工具 -> 依赖 -> 生成  

## 上下文
在 `docker build` 命令最后指定，与 Dockerfile 的位置无关。  

## 指令
### [FROM](https://docs.docker.com/engine/reference/builder/#from)
设置基础 image。  

### [LABEL](https://docs.docker.com/engine/reference/builder/#label)
```
LABEL <key>=<value> <key>=<value> <key>=<value> ...
```
>空格必须转义或将整个值用引号包围。内部的双引号要转义。  

### [RUN](https://docs.docker.com/engine/reference/builder/#run)
两种语法：  
- `RUN <command>` (shell form, the command is run in a shell, which by default is /bin/sh -c on Linux or cmd /S /C on Windows)  
- `RUN ["executable", "param1", "param2"]` (exec form)  

>不要将 `RUN apt-get update && apt-get install -y` 分开。  
```
RUN apt-get update && apt-get install -y \
    aufs-tools \
    s3cmd=1.1.* \
 && rm -rf /var/lib/apt/lists/*
```

使用管道：  
```
RUN set -o pipefail && wget -O - https://some.site | wc -l > /number
RUN ["/bin/bash", "-c", "set -o pipefail && wget -O - https://some.site | wc -l > /number"]
```

### [CMD](https://docs.docker.com/engine/reference/builder/#cmd)
- `CMD ["executable","param1","param2"]` (exec form, this is the preferred form)
- `CMD ["param1","param2"]` (as default parameters to ENTRYPOINT)
- `CMD command param1 param2` (shell form)

### [EXPOSE](https://docs.docker.com/engine/reference/builder/#expose)
`EXPOSE <port> [<port>/<protocol>...]`  

### [ENV](https://docs.docker.com/engine/reference/builder/#env)
```
ENV <key> <value>
ENV <key>=<value> ...
```

### [ADD or COPY](https://docs.docker.com/engine/reference/builder/#add)
- `ADD [--chown=<user>:<group>] <src>... <dest>`  
- `ADD [--chown=<user>:<group>] ["<src>",... "<dest>"]` (this form is required for paths containing whitespace)  
- `COPY [--chown=<user>:<group>] <src>... <dest>`  
- `COPY [--chown=<user>:<group>] ["<src>",... "<dest>"]` (this form is required for paths containing whitespace)  

>除非要用 `ADD` 自动对 tar 文件解压，复制文件使用 `COPY`。  
>不要用 `ADD` 下载远程文件，请用 `curl/wget`。  

>当 `COPY` 多个源文件，目标文件必须是目录并且以 `/` 结尾。  

## [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint)
- `ENTRYPOINT ["executable", "param1", "param2"]` (exec form, preferred)  
- `ENTRYPOINT command param1 param2` (shell form)  

## [VOLUME](https://docs.docker.com/engine/reference/builder/#volume)
```
VOLUME ["/data"]
VOLUME /var/log /var/db
```

>强烈推荐使用 `VOLUME` 创建镜像中易变的、用户可用的部分。  



## [USER](https://docs.docker.com/engine/reference/builder/#user)
```
USER <user>[:<group>]
USER <UID>[:<GID>]
```

## [WORKDIR](https://docs.docker.com/engine/reference/builder/#workdir)
`WORKDIR /path/to/workdir`  

>请使用绝对路径。  
>使用 `WORKDIR`，别用 `RUN cd … && do-something`。  

## [ONBUILD](https://docs.docker.com/engine/reference/builder/#onbuild)
`ONBUILD [INSTRUCTION]`  

把 `ONBUILD` 视为传递给子镜像的 Dockerfile 的指令。  

