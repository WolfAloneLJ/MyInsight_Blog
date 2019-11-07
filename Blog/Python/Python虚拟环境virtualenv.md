### Python虚拟环境virtualenv


#### 安装virtualenv
python3.6.3版本自带了pip，为了减少安装步骤，使用pip安装；

cmd，打开windows命令行；
```shell script
pip install virtualenv

pip install virtualenvwrapper # 这是对virtualenv的封装版本，一定要在virtualenv安装后安装

```
安装完成后，输入`pip list`,查看当前的所有安装包

#### 创建虚拟环境
```shell script
cd E:Python3 # 进入该文件
virtualenv envname # 创建一个名字为envname的虚拟环境
dir # 查看当前目录可以知道一个envname的文件已经被创建
```
注意：  
如果不识别virtualenv命令，可能是python安装路径没添加到系统环境变量或没安装virtualenv
或没有重新打开一个cmd窗口

启动虚拟环境
```shell script
# 进入虚拟环境文件
cd envname
# 进入相关的启动文件夹
CD Scripts

activate # 启动虚拟环境
deactivate # 退出虚拟环境
```
下面可以自由的在虚拟环境下安装各种包了

#### 问题与细节
每次需要启动虚拟环境的时候都需要进入虚拟环境的文件夹的Scripts的目录下，非常不方便，可以将Scripts的路径
添加到变量中  
如果系统还要安装其他的python版本，如python2.7.13；将其路径添加到环境变量后，进入安装文件目录，将
python.exe改为python2.exe，防止命令冲突  
如果同时存在多个python版本，那么pip也有多个版本，这个时候使用pip安装需要指定python版本
```shell script
python -m pip install XXXX # python3版本安装包
python2 -m pip install XXXX # python2版本安装包
```
每次添加了系统变量以后，需要关闭当前的cmd窗口，重新启动一个窗口才会生效。

#### 参考
[windows下python虚拟环境virtualenv安装和使用](https://www.cnblogs.com/cwp-bg/p/python.html)
[Windows下搭建Python虚拟环境](https://www.jianshu.com/p/ad2d8ee4a679)  

[Ubuntu中Python3虚拟环境的搭建](https://www.cnblogs.com/HeZhengfa/p/10486841.html)  


