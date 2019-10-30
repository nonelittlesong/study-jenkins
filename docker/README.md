
- [docker docs](https://docs.docker.com/get-started/)
- [krallin/tini](https://github.com/krallin/tini)

## 安装
#### 删除远古版本
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```
如果报告没有安装这些包，说明你的 docker 不是远古版，不必卸载。  

`/var/lib/docker/` 中保存了镜像、容器、卷和网络。  

#### 安装指定版本
```sh
apt-cache madison docker-ce
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
```

## Docker 不 Sudo
1. 添加 docker 组
   ```sh
   $ sudo groupadd docker
   ```
2. 添加用户到 docker 组
   ```sh
   $ sudo usermod -aG docker $USER
   ```
3. 使用 docker 组  
   临时的，仍需重启。  
   ```sh
   newgrp docker
   ```
4. 测试
   ```sh
   docker run hello-world
   ```

If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error, which indicates that your ~/.docker/ directory was created with incorrect permissions due to the sudo commands.  
```
WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied
```
To fix this problem, either remove the ~/.docker/ directory (it is recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:  
```
$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
$ sudo chmod g+rwx "$HOME/.docker" -R
```

## 指令概要
```sh
## List Docker CLI commands
docker
docker container --help

## 卸载
$ sudo apt-get purge docker-ce
$ sudo rm -rf /var/lib/docker
```
