
- [玩转 Jenkins Pipeline](https://blog.csdn.net/diantun00/article/details/81075007) by CSDN
- [Pipeline Docs](https://jenkins.io/doc/book/pipeline/)

## env
- [How to list all `env` properties within jenkins pipeline job?](https://stackoverflow.com/questions/37083285/how-to-list-all-env-properties-within-jenkins-pipeline-job)

```
stage('Print Env') {
    steps {
        printEnv()
        script {
            printEnv()
        }
    }
}

def printEnv() {
    env.getEnvironment().each {
        name, value -> println "Name: $name -> Value $value" 
    }
}
```

>**注意：**  
>第一次执行时会失败，因为不允许 `getEnvironment()`。  
>添加支持：  
><kbd>Manage Jenkins</kbd> > <kbd>In-process Script Approval</kbd> > <kbd>Approve</kbd>  

打印的环境变量：  
- BUILD_DISPLAY_NAME
- BUILD_ID
- BUILD_NUMBER
- BUILD_TAG
- BUILD_URL
- CLASSPATH
- HUDSON_HOME
- HUDSON_SERVER_COOKIE
- HUDSON_URL
- JENKINS_HOME
- JENKINS_SERVER_COOKIE
- JENKINS_URL
- JOB_BASE_NAME
- JOB_NAME
- JOB_URL

## git
添加验证：  
<kbd>Credentials</kbd> > <kbd>Add credentials</kbd>  

编辑 pipeline:  
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
- `input` - 不论在 `stage` 中的位置，一定在 `when` 之前执行。  

### 脚本式
