
- [docker docs](https://docs.docker.com/get-started/)
- [krallin/tini](https://github.com/krallin/tini)

## docker 不 sudo
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

## Display Docker version and info
docker --version
docker version
docker info

## Execute Docker image
docker run hello-world

## List Docker images
docker image ls

## List Docker containers (running, all, all in quiet mode)
docker container ls
docker container ls --all
docker container ls -aq
```
