## JDBC

### JDBC操作步骤
1.数据库和表  
2.创建一个项目  
3.导入驱动的jar包  
4.编码:
注册驱动  
获取连接  
编写SQL  
创建预编译的语句执行者  
设置参数  
执行SQL  
处理结果  
释放资源  

#### 初始化数据库和表
```
CREATE DATABASE day07;
USE day07;	
		
create table category(
    cid varchar(20) primary key,
    cname varchar(20)
);
		
insert into category values('c001','电器');
insert into category values('c002','服饰');
insert into category values('c003','化妆品');
insert into category values('c004','书籍');
```

#### 使用junit单元测试
要求：
1.方法是public void xxx(){}
2.在方法上添加 @Test
3.在@Test 按下 ctrl+1(快速锁定错误)			
4.在方法上右键 run as  -->junit 就可以执行方法了.  

##### 常见配置文件格式:  
1.properties  
里面内容的格式 key=value  
2.xml  


若我们的配置文件为properties,并且放在src目录下.  
我们可以通过 ResourceBundle工具快速获取里面的配置信息  
使用步骤:  
1.获取ResourceBundle 对象:  
static ResourceBundle getBundle("文件名称不带后缀名")   
2.通过ResourceBundle 对象获取配置信息   
String getString(String key) :通过执行key获取指定的value  


### 通过连接池(数据源)优化我们的操作


### 增强方法
1.继承   
2.装饰者模式(静态代理)  
3.动态代理  

