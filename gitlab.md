参考：  

- [Jenkins < Gitlab Docs](https://docs.gitlab.com/ee/integration/jenkins.html)
- [Gitlab Plugin < Jenkins](https://wiki.jenkins.io/display/JENKINS/GitLab+Plugin)
- [jenkinsci/gitlab-plugin](https://github.com/jenkinsci/gitlab-plugin)
- [Violation Comments to GitLab Plugin](https://wiki.jenkins.io/display/JENKINS/Violation+Comments+to+GitLab+Plugin)

依赖：  

- [GitLab Plugin](https://wiki.jenkins.io/display/JENKINS/GitLab+Plugin)
- [Git Plugins](https://wiki.jenkins.io/display/JENKINS/Git+Plugin)
- Git clone access for Jenkins from the GitLab repository
- GitLab API access to report build status

```diff
! 注意：
! Gitlab 8.3 之后，使用 GitLab Plugin，弃用 GitLab Hook Plugin。  
```

## [docker gitlab](https://docs.gitlab.com/omnibus/docker/)
### [参考1](https://cloud.tencent.com/developer/article/1326532)
准备镜像  
```
docker pull gitlab/gitlab-ce:latest
```
准备 gitlab 所需目录  
```
mkdir gitlab
cd gitlab
mkdir config logs data
```
准备启动脚本  
```sh
#! /bin/bash

sudo docker run -d --restart always \
    -p 8088:8088 \
    --name gitlab \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://118.24.64.246:8088/'; gitlab_rails['lfs_enabled'] = true;" \
    -v $PWD/config:/etc/gitlab \
    -v $PWD/logs:/var/log/gitlab \
    -v $PWD/data:/var/opt/gitlab \
    -it gitlab/gitlab-ce:latest

```
### [参考2](https://blog.csdn.net/u011054333/article/details/61532271)
用下面的命令启动一个默认配置的Gitlab。如果我们只在本机测试使用的话，将hostname替换为localhost。如果需要让外部系统也能访问的话使用外网IP地址。  
```sh
sudo docker run --detach \
    --hostname gitlab.example.com \
    --publish 443:443 --publish 80:80 --publish 22:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
```
如果这些配置还是不能满足你的需求的时候，还可以直接配置Gitlab。首先进入到Docker环境中。我们使用下面的命令进入Docker环境的bash中。gitlab是刚刚指定的Gitlab名称。
```
sudo docker exec -it gitlab /bin/bash
```

然后就进入了Docker的环境中，我们可以把它当作一个独立的系统来使用。然后编辑/etc/gitlab/gitlab.rb文件，这是Gitlab的全局配置文件。所有选项都可以在这里配置。
```
nano /etc/gitlab/gitlab.rb
```
[Configuration options](https://docs.gitlab.com/omnibus/settings/configuration.html)

## Troubleshooting
### Gitlab 的 webhook url 不能使用本地链接
```diff
- error:  Requests to the local network are not allowed
```
[Webhooks and insecure internal web services](https://docs.gitlab.com/ee/security/webhooks.html)

### docker gitlab ssh 端口配置
- https://blog.csdn.net/wo18237095579/article/details/81105264  
- https://docs.gitlab.com/omnibus/docker/#expose-gitlab-on-different-ports  
```sh
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 8929:8929 --publish 2289:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```
gitlab.rb  
```
# For HTTP
external_url "http://gitlab.example.com:8929"

or

# For HTTPS (notice the https)
external_url "https://gitlab.example.com:8929"

gitlab_rails['gitlab_shell_ssh_port'] = 2289
```

### 权限问题
需分配额外权限：  
```sh
--privileged
```
