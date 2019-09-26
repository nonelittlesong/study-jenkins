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

## [docker gitlab](https://cloud.tencent.com/developer/article/1326532)
拉取镜像：  
```
docker pull gitlab/gitlab-ce:latest
```
创建数据卷：  
```
mkdir gitlab
cd gitlab
mkdir config logs data
```
编辑启动脚本：  
```
#! /bin/bash

sudo docker run -d --rm \
    -p 8088:8088 \
    --name gitlab \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://118.24.64.246:8088/'; gitlab_rails['lfs_enabled'] = true;" \
    -v $PWD/config:/etc/gitlab \
    -v $PWD/logs:/var/log/gitlab \
    -v $PWD/data:/var/opt/gitlab \
    gitlab/gitlab-ee:latest
EOF
```

## Troubleshooting
```diff
- error:  Requests to the local network are not allowed
```
[Webhooks and insecure internal web services](https://docs.gitlab.com/ee/security/webhooks.html)
