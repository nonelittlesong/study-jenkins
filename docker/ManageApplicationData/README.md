# 存储总览
数据默认存储在可写容器层，这意味着：  

- 容器销毁后数据就不存在了，容器外很难访问这些数据。  
- 和运行容器的主机紧密的绑定，数据很难迁移。  
- 性能差。  

有两种方法保存数据： `volumes` 和 `bind mount`。  
Linux 还可用 `tmpfs mount`， Windows 还可用 `named pipe`。  


>**注意：**  
>`bind mounts` 和 `volumes` 都可以使用 `-v, --volume` 和 `--mount` 挂载到容器中。  
>推荐使用 `--mount`，它的语法更清晰。  

## 用例
### volumes

- 存储数据到远程主机。  

### bind mounts

- 共享配置文件。  
- 共享源码。  

## 贴示

- 把空的 `volume` 挂在到容器的已存在的文件或目录中，容器中的文件会复制到 `volume`。  
- 把 `bind mount` 或 非空 `volume` 挂载到容器的已存在的文件或目录中，容器中的文件会被隐藏（并非移除或替换）。  
