参考：  
- [jenkins pipeline中获取shell命令的标准输出或者状态](https://blog.csdn.net/liurizhou/article/details/86670092)

```
//获取标准输出
//第一种
result = sh returnStdout: true ,script: "<shell command>"
result = result.trim()
//第二种
result = sh(script: "<shell command>", returnStdout: true).trim()
//第三种
sh "<shell command> > commandResult"
result = readFile('commandResult').trim()

//获取执行状态
//第一种
result = sh returnStatus: true ,script: "<shell command>"
result = result.trim()
//第二种
result = sh(script: "<shell command>", returnStatus: true).trim()
//第三种
sh '<shell command>; echo $? > status'
def r = readFile('status').trim()

//无需返回值，仅执行shell命令
//最简单的方式
sh '<shell command>'
```

例子：  
```
script {
    result = sshCommand remote: remote, command: 'ls -lrt'
    echo result
    result = result.trim()
    sh "echo \"${result}\" | grep Public"
}
```
