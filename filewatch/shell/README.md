
- [tail](https://www.runoob.com/linux/linux-comm-tail.html) - 输出文件最尾部。默认输出文件最后10行。

## tail
```sh
ping www.baidu.com > tailTest/tailFile &
tail -f tailTest/tailFile
^C # 结束当前进程
fg %1
^C
```
```
# jobs      查看任务，返回任务编号n和进程号

# bg %n     将编号为n的任务转后台运行
# fg %n     将编号为n的任务转前台运行

# ctrl+z    挂起当前任务
# ctrl+c    结束当前任务
```
