## JDBC


### 回顾:
sql
	sql分类:
		DDL:
			对象:数据库和表
			关键词:create alter drop truncate
			创建数据库:create database day06;
			删除数据库: drop database day06;
			创建表:create table user(
				id int primark key  auto_increment,
				username varchar(20)
			);
			
			修改表:
				alter table user rename to user10;
				alter table user add password varchar(20);
				alter table user change password pwd varchar(20);
				alter table user modify pwd int;
				alter table user drop pwd;
			
			删除表:
				drop table user;
				
			常用的命令:
				use day06;
				show tables;
				desc user;
				show create table user;
			
		DML:
			对象:记录(行)
			关键词:insert update delete
			插入:
				insert into user values(字段值1,字段值2,...);-- 所有的字段
				insert into user(字段1,字段2....) values(字段值1,字段值2);-- 插入指定的字段
			更新:
				update user set 字段=字段值1,字段2=字段值2 where 条件;
			删除:
				delete from user where 条件;
			扩展:
				以后开发中很少使用delete,数据无价,删除有物理和逻辑(常用),
					逻辑删除一般会在表中添加一个字段(isdel:若值为1,代表删除了;若为0代表没有删除),
					此时的删除操作变成了更新操作.
		DQL:
			select ... from 表名 where 条件 group by 分组字段 having 条件 order by 排序字段;
			执行顺序:
			 1.确定数据来自那张表  from
			 2.是否需要筛选  where 
			 3.是否需要分组 group by
			 4.分组后是否需要筛选 having
			 5.是否需要排序 order by
			 6.确定显示那些数据. select
		DCL:用户 权限 事务
////////////////////////
auto_increment 自增
truncate 干掉表,重新创建 和delete的区别
数据类型:
	int 和 varchar(size):可变长度
	date time  datetime timestamp
////////////////////////////////////
多表的操作:
	表与表之间的关系:  
		一对多:  
			在多表的一方添加一个外键,外键的名称一般是主表名称_id,外键的类型和主表的主键的类型保持一致
			为了保证数据的有效性和完整性,
				需要在多表上添加外键约束
					格式:
						alter table 多表 add [constraint [外键的名称]] foreign key(外键名称) references 主表名称(主键);
		多对多:
			添加一张中间表,存放两张表的主键,就可以将多对多拆分成两个一对多了
			为了保证数据的有效性和完整性,
				需要在中间表添加两个外键约束
		一对一:(了解)
			1.两个实体合二为一(字段比较少)
			2.将一张表的主键添加外键约束即可
/////////////////////////////
多表的查询:
	内连接:
		显式:
			select a.*,b.* from a join b on 条件;
		隐式:
			select a.*,b.* from a,b where 条件;
	外连接:
		左外连接:
			select a.*,b.* from a left join b on 条件;
			以a为主,展示所有数据,根据条件关联查询b表,满足条件则展示,不满足的话以null显示
	子查询::
		一个查询依赖于另一个查询.


### 案例1-通过jdbc完成单表的curd操作:
需求:
	对分类表完成操作.
技术分析:
	jdbc
///////////////////////
jdbc:
	java操作数据库.jdbc是oracle公司指定的一套规范(一套接口)
	驱动:jdbc的实现类.由数据库厂商提供.
	我们就可以通过一套规范操作不同的数据库了(多态)
	jdbc作用:
		连接数据库
		发送sql语句
		处理结果
	
jdbc操作步骤:★
	1.数据库和表
	2.创建一个项目
	3.导入驱动jar包
	4.编码:
		注册驱动
		获取连接
		编写sql
		创建预编译的语句执行者
		设置参数
		执行sql
		处理结果
		释放资源

	初始化数据库和表:
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
	
	IDE打开之后
		1.修改字符集 utf-8
		2.新建 java项目
		3.使用的jdk为自己的jdk 不用使用内置
	
	使用junit单元测试
		要求:
			1.方法是public void xxx(){}
			2.在方法上添加 @Test
			3.在@Test 按下 ctrl+1(快速锁定错误)
			4.在方法上右键 run as  -->junit 就可以执行方法了.
jdbc-api详解:
	所有的包 都是 java.sql 或者 javax.sql
	
	DriverManager:管理了一组jdbc的操作 类
		常用方法:
			了解:注册驱动	
				static void registerDriver(Driver driver) :
					通过查看 com.mysql.jdbc.Driver的源码 有如下代码
						 static {
							try {
								java.sql.DriverManager.registerDriver(new Driver());//这段代码我们已经写过
							} catch (SQLException E) {
								throw new RuntimeException("Can't register driver!");
							}
						}
					驱动注册了两次.我们只需要将静态代码块执行一次,类被加载到内存中会执行静态代码块,并且只执行一次.
					现在只需要将类加载到内存中即可:
						方式1:
							★Class.forName("全限定名");//包名+类名   com.mysql.jdbc.Driver
						方式2:
							类名.class;
						方式3:
							对象.getClass();
 
			掌握:获取连接
				static Connection getConnection(String url, String user, String password) 
					参数1:告诉我们连接什么类型的数据库及连接那个数据库
								协议:数据库类型:子协议 参数
						mysql:	jdbc:mysql://localhost:3306/数据库名称
						oracle:	jdbc:oracle:thin@localhost:1521@实例
						
					参数2:账户名 root
					参数3:密码
	
	
	(了解)Driver:java.sql 接口 驱动
	Connection:连接 接口
		常用方法:
			获取语句执行者:
				(了解)Statement createStatement() :获取普通的语句执行者  会出现sql注入问题
				★PreparedStatement prepareStatement(String sql) :获取预编译语句执行者
				(了解)CallableStatement prepareCall(String sql):获取调用存储过程的语句执行者

			了解:
				setAutoCommit(false) :手动开启事务
				commit():提交事务
				rollback():事务回滚
	
	Statement:语句执行者 接口
	PreparedStatement:预编译语句执行者 接口
		常用方法:
			设置参数:
				setXxx(int 第几个问号,Object 实际参数);
					常见的方法:
						 setInt
						 setString
						 setObject
			
			执行sql:
				 ResultSet executeQuery() :执行 r 语句 返回值:结果集
				 int executeUpdate() :执行cud 语句 返回值:影响的行数
 
	
	ResultSet:结果集 接口
		执行查询语句之后返回的结果
			常用方法:
				boolean next():判断是否有下一条记录,若有返回true且将光标移到下一行,若没有呢则返回false
					光标一开始处于第一条记录的上面
				
				获取具体内容
					getXxx(int|string)
						若参数为int :第几列
						若参数为string:列名(字段名)
					例如:
						获取cname的内容可以通过
							getString(2)
							getString("cname")
					常用方法:
						getInt
						getString 也可以获取int值
						getObject 可以获取任意
///////////////////////
常见的配置文件格式:
	1.properties
		里面内容的格式 key=value
	2.xml
/////////////////
若我们的配置文件为properties,并且放在src目录下.
我们可以通过 ResourceBundle工具快速获取里面的配置信息
	使用步骤:
		1.获取ResourceBundle 对象:
			static ResourceBundle getBundle("文件名称不带后缀名") 
		2.通过ResourceBundle 对象获取配置信息 
			String getString(String key) :通过执行key获取指定的value

### 案例2-通过连接池(数据源)优化我们的操作.
需求:
	使用jdbc的时候,没操作一次都需要获取连接(创建)用完之后把连接释放掉了(销毁),通过连接池来优化curd操作.
技术分析:
	连接池
////////////////////
连接池概述:
	管理数据库的连接,
	作用:
		提高项目的性能.
	就是在连接池初始化的时候存入一定数量的连接,用的时候通过方法获取,不用的时候归还连接即可.
	所有的连接池必须实现一个接口 javax.sql.DataSource接口
	
	获取连接方法:
		Connection getConnection() 
	归还连接的方法就是以前的释放资源的方法.调用connection.close();
自定义一个连接池(理解思想)
	
常用连接池:
	DBCP
	C3P0
///////////////////
增前方法
	1.继承
	2.装饰者模式(静态代理)
	3.动态代理
//////////////
装饰者模式:★★★
	使用步骤:
		1.装饰者和被装饰者实现同一个接口或者继承同一个类
		2.装饰者中要有被装饰者的引用
		3.对需要增强的方法进行加强
		4.对不需要加强的方法调用原来方法
 ////////////////////////////////////
 常用的连接池:
	DBCP:(理解)
		apache组织
		使用步骤:
			1.导入jar包(commons-dbcp-1.4.jar和commons-pool-1.5.6.jar)
			2.使用api
				a.硬编码
					//创建连接池
					BasicDataSource ds = new BasicDataSource();
					
					//配置信息
					ds.setDriverClassName("com.mysql.jdbc.Driver");
					ds.setUrl("jdbc:mysql:///day07");
					ds.setUsername("root");
					ds.setPassword("1234");
				b.配置文件
					实现编写一个properties文件
					//存放配置文件
					Properties prop = new Properties();
					prop.load(new FileInputStream("src/dbcp.properties"));
					//设置
					//prop.setProperty("driverClassName", "com.mysql.jdbc.Driver");
					
					//创建连接池
					DataSource ds = new BasicDataSourceFactory().createDataSource(prop);
	C3P0:(★)
		hibernate和spring使用
		有自动回收空闲连接的功能.
		使用步骤:
			1.导入jar包(c3p0-0.9.1.2.jar)
			2.使用api
				a.硬编码(不推荐)
					new ComboPooledDataSource()
				b.配置文件
					配置文件的名称:c3p0.properties 或者 c3p0-config.xml
					配置文件的路径:src下
				
					编码只需要一句话
						new ComboPooledDataSource()//使用默认的配置
						new ComboPooledDataSource(String configName)//使用命名的配置 若配置的名字找不到,使用默认的配置
						

### 案例3-使用dbutils完成curd操作
技术分析:
	dbutils
dbutils:
	是apache组织的一个工具类,jdbc的框架,更方便我们使用
	使用步骤:
		1.导入jar包(commons-dbutils-1.4.jar)
		2.创建一个queryrunner类
			queryrunner作用:操作sql语句
				构造方法:
					new QueryRunner(Datasource ds);
		3.编写sql
		4.执行sql
			query(..):执行r操作
			update(...):执行cud操作
////////////////////////////

核心类或接口  
	QueryRunner:类名  
		作用:操作sql语句  
		构造器:  
			new QueryRunner(Datasource ds);  
		注意:  
			底层帮我们创建连接,创建语句执行者 ,释放资源.  
		常用方法:  
			query(..):  
			update(..):  
	
	
	DbUtils:释放资源,控制事务 类  
		closeQuietly(conn):内部处理了异常  
		commitAndClose(Connection conn):提交事务并释放连接  
		....
	
	ResultSetHandler:封装结果集 接口  
		
		 ArrayHandler, ArrayListHandler, BeanHandler, BeanListHandler, ColumnListHandler, KeyedHandler, MapHandler, MapListHandler, ScalarHandler  
		 
		 (了解)ArrayHandler, 将查询结果的第一条记录封装成数组,返回  
		 (了解)ArrayListHandler, 将查询结果的每一条记录封装成数组,将每一个数组放入list中返回  
		 ★★BeanHandler, 将查询结果的第一条记录封装成指定的bean对象,返回  
		 ★★BeanListHandler, 将查询结果的每一条记录封装成指定的bean对象,将每一个bean对象放入list中 返回.   
		 (了解)ColumnListHandler, 将查询结果的指定一列放入list中返回   
		 (了解)MapHandler, 将查询结果的第一条记录封装成map,字段名作为key,值为value 返回  
		 ★MapListHandler, 将查询结果的每一条记录封装map集合,将每一个map集合放入list中返回  
		 ★ScalarHandler,针对于聚合函数 例如:count(*) 返回的是一个Long值  
		
		
		
		
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
	
  
### 上午回顾:  
jdbc:  
	java语言操作数据库  
	jdbc是oracle公司指定的一套规范,  
	驱动:jdbc的实现类,由数据库厂商提供.  
jdbc操作步骤:  
	1.导入驱动jar包  
	2.注册驱动  
	3.获取连接  
	4.编写sql  
	5.获取语句执行者  
	 		PreparedStatement st=conn.prepareStatement(sql);  
	6.设置参数  
			st.setXxx(int 第几个问号,Object 实参);  
	7.执行sql  
		ResultSet rs=st.executeQuery();
		int i=st.executeUpdate();
	8.处理结果
		若是resultset
			while(rs.next()){
				rs.getXxx(int|String)
			}
	9.释放资源
	
////////////////////////////////////////  
获取src目录下的properties格式的配置文件  
	ResourceBundle bundle=ResourceBundle.getBundle("不带后缀名的文件名");  
	String value = bundle.getString("key");　  
////////////////////////  
自定义连接池:  
增强方法:  
	1.继承  
	2.装饰者模式(静态代理)  
	3.动态代理  
///////////////  
装饰者模式(静态代理)  
	1.装饰者和被装饰者实现同一个接口或者继承同一个类  
	2.在装饰者中要有被装饰者的引用  
	3.对需要增强的方法进行加强  
	4.对不需要加强的方法调用原来方法  
///////////////////  
常见连接池:  
	dbcp:  
	c3p0:★  
		配置文件:  
			名称:c3p0.properties或者 c3p0-config.xml  
			位置:src下  
		使用:  
			new ComboPooledDataSource()  
////////////////  
dbutils:  
	工具类,封装了jdbc的操作.  
	使用步骤:  
		1.导入jar包  
		2.创建queryrunner类  
		3.编写sql  
		4.执行sql  
queryrunner:操作sql语句  
	构造器:    
		new queryrunner()    
	方法:    
		query(..)  
		update(..)  
ResultSetHandler:封装结果集  
	BeanHandler    
	BeanListHandler    
	MapListHandler  
	ScalarHandler