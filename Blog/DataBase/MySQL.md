## MySQL数据库

安装MySQL
```
sudo apt-get install mysql-server
apt-get isntall mysql-client
sudo apt-get install libmysqlclient-dev
```
首先检查系统中是否已经安装了MySQL
```
sudo netstat -tap | grep mysql
```

### 实现远程控制MySQL
1.编辑文件
```
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
```
注释掉 `bind-address = 127.0.0.1：`

2.登录数据库
```
mysql -u root -p 
```
在MySQL环境下执行授权命令(授权给远程电脑登录数据库)
```
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '你的密码' WITH GRANT OPTION;
```
3.刷新配置信息
```
flush privileges;
```
4.重启数据库
```
service mysql restart
```

### MySQL其他命令
1.查看mysql是否在监听端口命令
```
netstat -tl | grep mysql
```
2.查看mysql是否启动命令
```
ps -aux | grep mysqld
```


### 数据库与存储图片
首先，图片上可以存储到数据库里的，可以通过二进制流将图片存到数据库中。

但是，`强烈不建议把图片存储到数据库中！！！！`首先对数据库的读/写的速度永远都赶不上文件系统处理的速度，其次数据库备份变的巨大，越来越耗时间，最后对文件的访问需要穿越你的应用层和数据库层。图片是数据库最大的杀手。一般来说数据库都是存储一个URL，然后再通过URL来调用图片。

图片，文件，二进制数这三样东西慎重存储到数据库中。现在很多企业都是这样来处理图片的，用MySQL数据库存储URL，图片则是存储在阿里云上。



### Linux下的MySQL


#### Navicat连接Ubuntu的MySQL失败(10061未知故障)
解决方法:  
1、打开`/etc/mysql/mysql.conf.d/mysqld.cnf`文件  
2、在`bind-address=127.0.0.1`前加#注释，或者直接删掉这行，或改写成`bind-address=0.0.0.0`  
3、保存关闭`mysqld.cnf`文件，输入`service mysql restart`重启`mysql`数据库  
 再次使用navicat重新连接
 
 
 ### 参考
 [已解决：mysql无法远程访问10061错误，各种方式授权后也无效（ubuntu 16.04LTS mysql 5.7.13）](https://blog.csdn.net/xx1710/article/details/52446703)  
 
 [在Ubuntu上安装mysql](https://blog.csdn.net/zxjohnson/article/details/79360716)  
 
 
 


### 参考：
[ubuntu16.04下安装mysql详细步骤](https://blog.csdn.net/itxiaolong3/article/details/77905923)  
[数据库一般不用来存储图片](https://www.cnblogs.com/mlgjb/p/8794659.html)  

[在Windows上安装 MySQL 8.0 教程（默认选项 Developer Default 安装）](https://blog.csdn.net/qq_36761831/article/details/82384775)  
[Windows10下安装MySQL8.0](https://www.cnblogs.com/tangyb/p/8971658.html)  
[MySQL：MySQL Workbench的使用](https://www.cnblogs.com/hahayixiao/p/9849742.html)  




### 参考:
[MySQL存储文本和图片](https://blog.csdn.net/u010512964/article/details/59549110)  


[MySQL、MongoDB、Redis 数据库之间的区别](https://blog.csdn.net/CatStarXcode/article/details/79513425)  
[Python3 MySQL 数据库连接 - PyMySQL 驱动](https://www.runoob.com/python3/python3-mysql.html)  


[pymysql连接和操作Mysql数据库](https://blog.csdn.net/qq_41432935/article/details/83001381)  
[python3使用pymysql连接mysql数据库的大坑](https://blog.csdn.net/yy_meng11/article/details/78568507)  
[Python连接MySQL数据库之pymysql模块使用](https://www.cnblogs.com/chongdongxiaoyu/p/8951433.html)  


[如何将图片储存在MySQL数据库中](https://blog.csdn.net/yugemengjing/article/details/78389352)  
[往MySQL中存储图片](https://blog.csdn.net/hope2jiang/article/details/590733)  
[关于图片或者文件在数据库的存储方式归纳](https://blog.csdn.net/a407479/article/details/51644602)  

[Python3 MySQL 数据库连接 - PyMySQL 驱动](https://www.runoob.com/python3/python3-mysql.html)  

