## 必须以 `From` 开头
```diff
- Error response from daemon: No build stage in current context
```

## 缺少依赖
缺少 gcc 依赖：  
```diff
- standard_init_linux.go:211: exec user process caused "no such file or directory"
```
### 解决方案
Dockerfile 以 `From gcc:latest` 开头。  

或者

使用静态编译 `gcc test.c -static`，再构建镜像。  

