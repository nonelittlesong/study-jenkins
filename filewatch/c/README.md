
- [用 inotify 监控 Linux 文件系统事件](https://www.ibm.com/developerworks/cn/linux/l-inotify/)
- [inotify < linux man page](http://man7.org/linux/man-pages/man7/inotify.7.html)
- [inotify-tools](https://github.com/rvoicilas/inotify-tools)
- [inotifywait](https://linux.die.net/man/1/inotifywait)
- [rsync](https://rsync.samba.org/)
- [sersync](https://github.com/wsgzao/sersync)


## inotify-tools
一个 C 库和一组命令行。  

参考：  
- [inotifywait文件监控](https://www.jianshu.com/p/57e3819a2e7c)

### 查看系统是否支持 inotify
```
ll /proc/sys/fs/inotify
```
输出：  
```
total 0
-rw-r--r-- 1 root root 0 Sep 24 10:48 max_queued_events
-rw-r--r-- 1 root root 0 Sep 24 10:48 max_user_instances
-rw-r--r-- 1 root root 0 Sep 24 10:48 max_user_watches
```
