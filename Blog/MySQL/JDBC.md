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






