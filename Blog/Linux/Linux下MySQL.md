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
 
 
 