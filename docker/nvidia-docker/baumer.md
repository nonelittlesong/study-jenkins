## Baumer 摄像头 SDK 依赖
使用 docker 的 ubuntu 镜像安装 baumer sdk 时，会因为缺少依赖而失败：  
```
Selecting previously unselected package baumer-gapi-sdk-linux.
(Reading database ... 22818 files and directories currently installed.)
Preparing to unpack baumer-gapi-sdk-linux-v2.9.2.22969-Ubuntu-16.04-x86-64.deb ...
Unpacking baumer-gapi-sdk-linux (2.9.2.22969-Ubuntu-16.04-x86-64) ...
dpkg: dependency problems prevent configuration of baumer-gapi-sdk-linux:
 baumer-gapi-sdk-linux depends on libdrm2 (>= 2.4.91); however:
  Package libdrm2 is not installed.
 baumer-gapi-sdk-linux depends on libgtkglext1 (>= 1.2.0); however:
  Package libgtkglext1 is not installed.
 baumer-gapi-sdk-linux depends on libilmbase12 (>= 2.2.0); however:
  Package libilmbase12 is not installed.
 baumer-gapi-sdk-linux depends on libopencv-core2.4v5 (>= 2.4.9.1+dfsg); however:
  Package libopencv-core2.4v5 is not installed.
 baumer-gapi-sdk-linux depends on libopencv-highgui2.4v5 (>= 2.4.9.1+dfsg); however:
  Package libopencv-highgui2.4v5 is not installed.
 baumer-gapi-sdk-linux depends on libopencv-imgproc2.4v5 (>= 2.4.9.1+dfsg); however:
  Package libopencv-imgproc2.4v5 is not installed.
 baumer-gapi-sdk-linux depends on libopenexr22 (>= 2.2.0); however:
  Package libopenexr22 is not installed.
 baumer-gapi-sdk-linux depends on libpangox-1.0-0 (>= 0.0.2); however:
  Package libpangox-1.0-0 is not installed.
 baumer-gap
dpkg: error processing package baumer-gapi-sdk-linux (--install):
 dependency problems - leaving unconfigured
Processing triggers for mime-support (3.59ubuntu1) ...
Errors were encountered while processing:
 baumer-gapi-sdk-linux
```
根据错误提示，安装依赖：  
```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
You might want to run 'apt-get -f install' to correct these:
The following packages have unmet dependencies:
 baumer-gapi-sdk-linux : Depends: libgtkglext1 (>= 1.2.0) but it is not going to be installed
                         Depends: libilmbase12 (>= 2.2.0) but it is not going to be installed
                         Depends: libopencv-core2.4v5 (>= 2.4.9.1+dfsg) but it is not going to be installed
                         Depends: libopencv-highgui2.4v5 (>= 2.4.9.1+dfsg) but it is not going to be installed
                         Depends: libopencv-imgproc2.4v5 (>= 2.4.9.1+dfsg) but it is not going to be installed
                         Depends: libopenexr22 (>= 2.2.0) but it is not going to be installed
                         Depends: libpangox-1.0-0 (>= 0.0.2) but it is not going to be installed
                         Depends: libv4l-0 (>= 1.10.0) but it is not going to be installed
                         Depends: libv4lconvert0 (>= 1.10.0) but it is not going to be installed
                         Depends: libx11-xcb1 (>= 2:1.6.3) but it is not going to be installed
                         Depends: libxcb-dri2-0 (>= 1.11.1) but it is not going to be installed
                         Depends: libxcb-dri3-0 (>= 1.11.1) but it is not going to be installed
                         Depends: libxcb-glx0 (>= 1.11.1) but it is not going to be installed
                         Depends: libxcb-present0 (>= 1.11.1) but it is not going to be installed
                         Depends: libxcb-sync1 (>= 1.11.1) but it is not going to be installed
                         Depends: libxmu6 (>= 2:1.1.2) but it is not going to be installed
                         Depends: libxshmfence1 (>= 1.2) but it is not going to be installed
                         Depends: libxt6 (>= 1:1.1.5) but it is not going to be installed
                         Depends: libxxf86vm1 (>= 1:1.1.4) but it is not going to be installed
 libdrm2 : Depends: libdrm-common (>= 2.4.91-2~16.04.1) but it is not going to be installed
E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).
```

原因：  
`baumer-gapi-sdk-linux` 残留，导致依赖安装失败。  

**解决方法：**  
先卸载 `baumer-gapi-sdk-linux`：  
```sh
dpkg -P baumer-gapi-sdk-linux
```
再安装依赖：  
```sh
apt-get install libdrm2 libgtkglext1 libilmbase12 libopencv-core2.4v5 libopencv-highgui2.4v5 \
libopencv-imgproc2.4v5 libopenexr22 libpangox-1.0-0 libv4l-0 libv4lconvert0 \
libx11-xcb1 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 \
libxcb-sync1 libxmu6 libxshmfence1 libxt6 libxxf86vm1
```
还要解决 `udevadm: command not found` 的问题：  
```sh
apt-get install udev
```
最后，安装 baumer sdk：  
```sh
dpkg -i baumer-gapi-sdk-linux-v2.9.2.22969-Ubuntu-16.04-x86-64.deb
```
