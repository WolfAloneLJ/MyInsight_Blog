##  Ubuntu上MySQL

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



### 参考：
[ubuntu16.04下安装mysql详细步骤](https://blog.csdn.net/itxiaolong3/article/details/77905923)

[数据库一般不用来存储图片](https://www.cnblogs.com/mlgjb/p/8794659.html)

