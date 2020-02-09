## iOS数据存储





###  iOS客户端持久化存储——从模型到数据库


db文件保存的路径为本地路径  
如：  
`[[NSBundle mainBundle] pathForResource:@"myDatabase" ofType:@"db"];`  
会出现此数据库文件为只读属性  
造成此数据库文件不可修改  
如果一定要到这种文件的话就把这个文件copy到本程序沙盒

##### 数据库错误
错误：
`attempt to write a readonly database`
原因：

sqlite3所在的文件夹没有读写权限，或者权限不足

解决办法：

1.普通用户的话提升文件夹的权限
```shell script
chmod 777 db.sqlite3
cd ..  
chmod 777  *
```

2.将项目移动到有全部权限的文件夹下启动   

#### 参考
[iOS客户端持久化存储——从模型到数据库](https://blog.csdn.net/show3/article/details/54924713)  
[基于FMDB的数据库模型，线程安全的无SQL数据库工具](https://github.com/TonyJR/TODBModel)  
[iOS端数据库解决方案分析](http://www.cocoachina.com/ios/20161108/18001.html)  
[SQLite 并发的四种处理方式](https://xiaozhuanlan.com/topic/1698752340)


[Swift4中Codable的使用（一）](https://www.jianshu.com/p/5dab5664a621)  


[SQLite.swift 使用与封装](https://www.jianshu.com/p/73e423921cdb)  
[Swift3.0 SQLite使用、性能优化、线程安全](https://www.jianshu.com/p/fdeadf4cb782)  
[iOS 多线程中使用SQLite](https://blog.csdn.net/xuhen/article/details/78967846)  
[ios sqlite3多线程操作](https://blog.csdn.net/nxjbill/article/details/77801947)  

[SQLite 并发的四种处理方式](https://bignerdcoding.com/archives/63.html)


[使用 GRDB 在 Swift 中操作 SQLite 数据库](http://swiftcafe.io/post/grdb?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)     
[GRDB.swift, 在应用程序开发中，一个用于SQLite数据库](https://www.helplib.com/GitHub/article_127687)  


[Swift 文件夹的检查创建和删除](https://blog.csdn.net/a136447572/article/details/78983374)  

[iOS attempt to write a readonly database](https://blog.csdn.net/u011423056/article/details/51726296)  

