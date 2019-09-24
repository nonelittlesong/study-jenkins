
- [docker docs](https://docs.docker.com/get-started/)

## docker 不 sudo
1. 添加 docker 组
   ```sh
   $ sudo groupadd docker
   ```
2. 添加用户到 docker 组
   ```sh
   $ sudo usermod -aG docker $USER
   ```
3. 更新
   ```sh
   newgrp docker
   ```
4. 测试
   ```sh
   docker run hello-world
   ```
   
