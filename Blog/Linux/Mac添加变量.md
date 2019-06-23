## Mac添加变量

Mac系统的环境变量，加载顺序为:  
- a. /etc/profile  
- b. /etc/paths  
- c. ~/.bash_profile  
- d. ~/.bash_login  
- e. ~/.profile  
- f. ~/.bashrc   

其中a和b是系统级别的，系统启动就会加载，其余是用户接别的。  
c,d,e按照从前往后的顺序读取，如果c文件存在，则后面的几个文件就会被忽略不读了，以此类推。  
~/.bashrc没有上述规则，它是bash shell打开的时候载入的。  
这里建议在c中添加环境变量，以下也是以在c中添加环境变量来演示的。  


### 参考
[mac 添加环境变量](https://blog.csdn.net/HandsomeFuHS/article/details/79687381)  
[mac终端更改环境变量/增加路径](https://blog.csdn.net/elffa/article/details/79532483)  
[Mac 配置路径](https://www.jianshu.com/p/5b83fc520173)  

