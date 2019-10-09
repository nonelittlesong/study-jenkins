
- [玩转 Jenkins Pipeline](https://blog.csdn.net/diantun00/article/details/81075007) by CSDN
- [Pipeline Docs](https://jenkins.io/doc/book/pipeline/)


Jenkinsfile (Declarative Pipeline):  
```
pipeline {
    agent any // 1
    stages {
        stage('Build') { // 2
            steps {
                // 3
            }
        }
        stage('Test') { // 4
            steps {
                // 5
            }
        }
        stage('Deploy') { // 6
            steps {
                // 7
            }
        }
    }
}
```
