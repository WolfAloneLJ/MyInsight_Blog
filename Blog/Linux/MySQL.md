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


### 参考：
[ubuntu16.04下安装mysql详细步骤](https://blog.csdn.net/itxiaolong3/article/details/77905923)
