# Best practices for writing Dockerfiles
构建高效的 images。  

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Dockerfile最佳实践](https://blog.csdn.net/nklinsirui/article/details/96113636) by CSDN

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


