
- [玩转 Jenkins Pipeline](https://blog.csdn.net/diantun00/article/details/81075007) by CSDN
- [Pipeline Docs](https://jenkins.io/doc/book/pipeline/)

## 语法
### 声明式
- `currentBuild.result` - 在 stages 中，为 `null`；在 post 中，为 `SUCCESS` 或其他。  
- `when` - 不能为空。  

### 脚本式