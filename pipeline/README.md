
- [玩转 Jenkins Pipeline](https://blog.csdn.net/diantun00/article/details/81075007) by CSDN
- [Pipeline Docs](https://jenkins.io/doc/book/pipeline/)

## 配置
- Discard old builds - 保留旧构建的策略。  
- Do not allow concurrent builds - 同时只能运行一个 build。  

## build
用于 steps 中，构建一个 job。  
- `job` - 使用相对路径或绝对路径。  
- `parameters` - 可选。  
  - booleanParam  
  - credentials  
  - file  
  - $class: 'JiraIssueParameterValue'  
  - $class: 'JiraVersionParameterValue'  
  - password  
  - run  
  - string  
  - text  
- propagate - 可选。 downstream build 的结果是否影响 step 的结果。   
- quietPeriod - 可选。  
- wait - 可选。  

### 例子
- [Pipeline pass parameters to downstream jobs](https://stackoverflow.com/questions/37025175/pipeline-pass-parameters-to-downstream-jobs)
- [How can I trigger another job from a jenkins pipeline (jenkinsfile) with GitHub Org Plugin?](https://stackoverflow.com/questions/36306883/how-can-i-trigger-another-job-from-a-jenkins-pipeline-jenkinsfile-with-github)

参数：  
```
stage('Starting ART job') {
    build job: 'RunArtInTest',
          parameters: [
              [$class: 'StringParameterValue', name: 'systemname', value: systemname],
              string(name: 'complex_param', value: 'prefix-' + String.valueOf(BUILD_NUMBER)),
              [$class: 'BooleanParameterValue', name: 'parameter_name', value: false],
              [$class: 'BooleanParameterValue', name: 'parameter_name2', value: Boolean.valueOf(update_composer)],
              [$class: 'BooleanParameterValue', name: 'parameter_name3', value: update_composer.toBoolean()]
          ]
}
```

并行触发多个 jobs：  
另外, 通过添加 failFast true， 当其中一个进程失败时，你可以强制所有的 parallel 阶段都被终止。  
```
stage ('Trigger Builds In Parallel') {
    steps {
        // Freestyle build trigger calls a list of jobs
        // Pipeline build() step only calls one job
        // To run all three jobs in parallel, we use "parallel" step
        // https://jenkins.io/doc/pipeline/examples/#jobs-in-parallel
        parallel (
            linux: {
                build job: 'full-build-linux', parameters: [string(name: 'GIT_BRANCH_NAME', value: env.BRANCH_NAME)]
            },
            mac: {
                build job: 'full-build-mac', parameters: [string(name: 'GIT_BRANCH_NAME', value: env.BRANCH_NAME)]
            },
            windows: {
                build job: 'full-build-windows', parameters: [string(name: 'GIT_BRANCH_NAME', value: env.BRANCH_NAME)]
            },
            failFast: false
        )
    }
}

// 另一种语法
stage('Build A and B') {
    failFast true
    parallel {
        stage('Build A') {
            steps {
                    build job: "/project/A/${env.BRANCH}", wait: true
            }
        }
        stage('Build B') {
            steps {
                    build job: "/project/B/${env.BRANCH}", wait: true
            }
        }
    }
}
```


## env
- [How to list all env properties within jenkins pipeline job?](https://stackoverflow.com/questions/37083285/how-to-list-all-env-properties-within-jenkins-pipeline-job)

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

## environment
```
pipeline {
    agent any
    
    environment {
        // 通过 env 访问。
        // 如果为 '' 空字符串， env.remote 为 null
        remote = 'hehe'
    }
    
    stages {
        stage('Test') {
            steps {
                echo remote            // 'hehe'
                
                // 声明式 pipeline 不能直接给变量赋值
                // def local = "gaga"  // 会报错
                
                script {
                    def local = 'gaga' // 局部变量，只能在当前的 script 块访问。
                    remote = 'hehehe'  // 全局变量，后面的 stage 也能访问。
                }
                
                echo remote            // 'hehehe' 屏蔽了 env.remote
            }
        }
        stage('Print Env') {
            steps {
                echo remote               // 'hehehe'
            
                printEnv()                // 没有 environment 定义的 remote
                sh 'env | sort'           // 包含 environment 定义的 remote
                echo env.remote           // 'hehe'
                echo "${env.remote}"      // 'hehe'
                // echo ${env.remote}     // 报错，不能直接使用 ${} 获取变量的值
                script {
                    echo env.remote       // 'hehe'
                    echo "${env.remote}"  // 'hehe'
                    printEnv()
                    env.remote = 'gagaga' // 不能改变 env.remote 的值
                    sh 'remote=gagaga'
                    
                    remote = 'hehehehe'
                }
                echo env.remote           // 'hehe'
            }
        }
        stage('Change Env') {
            steps {
                echo env.remote           // 'hehe'
                echo remote               // 'hehehehe'
            }
        }
    }
}
```

## git
用于 steps，获取源码。  

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
- steps  
  - `error` - `error 'string'`。 抛出异常。  
  - `input` - 不论在 `stage` 中的位置，一定在 `when` 之前执行。  
### 脚本式
