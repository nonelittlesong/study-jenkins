
- [玩转 Jenkins Pipeline](https://blog.csdn.net/diantun00/article/details/81075007) by CSDN
- [Pipeline Docs](https://jenkins.io/doc/book/pipeline/)

## git
<kbd>Credentials</kbd> > <kbd>Add credentials</kbd>  
![credential.png](https://github.com/nonelittlesong/study-resources/blob/master/images/Jenkins/credential.png)  

pipeline:  
```
pipeline {
    ...
    
    stages {
        stage('Pull Source Code') {
            steps {
                git branch: 'master',
                    credentialsId: '67039000-9451-493e-93b1-b2f2e784ea12',
                    url: 'http://127.0.0.1/songwu/jenkins-demo.git'
            }
        }
        ...
    }
    ...
}
```

## 语法
### 声明式
- `currentBuild.result` - 在 stages 中，为 `null`；在 post 中，为 `SUCCESS` 或其他。  
- `when` - 不能为空。  

### 脚本式
