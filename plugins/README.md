[Jenkins Plugins Index](https://plugins.jenkins.io/)

## SSH
- [SSH Pipeline Steps](https://plugins.jenkins.io/)
- [Publish over SSH](https://blog.csdn.net/houyefeng/article/details/51027885)

### Publish over SSH
<kbd>Manage Jenkins</kbd> > <kbd>Configure System</kbd> > <kbd>Publish over SSH</kbd>  
配置说明：  
- `Passphrase` - SSH 的密码。使用用户名/密码登录为用户密码，使用私钥登录为私钥密码。  
- `Path to key` - 私钥路径。  
- `Key` - 私钥。如果 `Path to key` 和 `Key` 都设置，那么 `Key` 的优先级更高。  
- `Disable exec` - 禁止执行命令，Job 中设置的命令都会忽略。

SSH Server：  
- `Name` - 给配置取个名字。  
- `Hostname` - 远程主机名。  
- `Username` - 远程用户名。  
- `Remote Derictory` - 文件传输到的远程目录。  

<kbd>Freestyle project</kbd> > <kbd>Build</kbd>
- `Name` - 前面取得名字。  
- `Source files` - 传输到远程目录的文件。  
- `Remove prefix` - 传输过程过滤掉的目录。  
- `Remote directory` - 前面配置的 `Remote directory` 的相对路径。  
- `Exec command` - 远程主机执行的脚本。  
