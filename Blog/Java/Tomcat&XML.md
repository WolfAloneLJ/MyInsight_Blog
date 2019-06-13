## 第八讲 Tomcat&XML
### 回顾:
jdbc:  
	java语言操作数据库  
	jdbc是一套规范,oracle公司制定的  
	驱动:jdbc的实现类,由数据库厂商提供    
	使用步骤:  
		1.导入jar包(驱动)  
		2.注册驱动  
			Class.forName("com.mysql.jdbc.Driver");  
		3.获取连接  
			DriverManager.getConnection("jdbc:mysql://loacalhost:3306/dayxx","root","123");  
		4.编写sql  
		5.创建语句执行者  
			PreparedStatement st=conn.prepareStatement(sql);  
		6.设置参数  
			st.setXxx(int 第几个问号,Object 实参);  
		7.执行sql  
			ResultSet rs=st.executeQuery();  
			int i=st.executeUpdate();  
		8.处理结果:  
			if(rs.next()){  
				rs.getXxx(int|String)  
			}  
		9.释放资源   
	properties:      
		形式 key=value    
		获取资源文件里面的内容 ResourceBundle    
		文件放在src下:  
			ResourceBundle bundle = ResourceBundle.getBundle("不带后缀名的文件名");    
			获取值:  
			String value = bundle.getString(key)    
	
连接池:  
	必须实现 javax.sql.DataSource 接口    
		获取连接:getConnnection();    
		归还连接:conn.close();    
	方法增前的方式:    
		1.继承    
		2.静态代理    
		3.动态代理    
	静态代理步骤:    
		a.要求装饰者和被装饰者实现同一个接口或者继承同一个类    
		b.要求装饰者要有被装饰者的引用    
		c.对需要加强的方法进行加强    
		d.对不需要加强的方法调用原来的方法    
	常见的连接池:    
		DBCP:    
			使用步骤:    
				1.导入jar包(两个jar包)     
				2.编码:    
					a.硬编码    
						new BasicDataSource()    
					b.配置文件    
						Properties prop=new Properties()    
						prop.load(is);    
						new BasicDataSourceFactory().createDataSource(Properties prop);    
		C3P0:    
			使用步骤:    
				1.导入jar包(1个)    
				2.编码:    
					b.配置文件    
						配置文件的名称:c3p0.properties 或者 c3p0-config.xml    
						配置文件的位置:src目录下    
						编码中通过构造器创建:    
							new ComboPooledDataSource();     
	  
dbutils:  
	apache组织提供的一个工具类,jdbc框架.  
	dbutils的使用步骤:  
		1.导入jar包  
		2.创建QueryRunner  
		3.编写sql  
		4.执行sql  
	核心的类或者接口  
		QueryRunner:类  操作sql  
			构造:  
				new QueryRunner(DataSource ds);  
			常用的方法:  
				query(..)  
				update(..)  
				
		DbUtils:类 释放资源和控制事务    
		ResultSetHandler:接口 封装结果集    
			BeanHandler:将查询的第一条结果封装成指定的bean对象    
			BeanListHandler:将查询的每一条结果封装成指定的bean对象,将所有的对象放入list中返回    
			MapListHandler:将查询的每一条结果封装成map,key是字段名,value是值,将所有的map放入list中返回  
			ScalarHandler:针对于聚合函数     
			

xml:
	可以编写简单的xml文件
	可以按照指定的约束文件编写xml文件  
tomcat:★  


### 案例1-编写配置文件,编写一个服务器软件,按照指定的全限定名,根据路径,让服务器创建这个对象,调用指定的方法
需求:
```
<a1>
	<c>hello</c>
	<d>com.itheima.HelloServlet</d>
</a1>
<b1>
	<c>hello</c>
	<e>/hello</e>
</b1>
```

技术分析:
	xml  
	解析xml  
	根据全限定名创建一个对象,调用方法  
  
xml:
	可扩展的标签语言    
	标签自定义.    
	作用:存储数据.(配置文件)    
	书写规范:  
		1.区分大小写    
		2.应该有一个根标签    
		3.标签必须关闭    
			<xx></xx>    
			<xx/>     
		4.属性必须用引号引起来,    
			<xx att="value"/>    
		5.标签体中的空格或者换行或者制表符等内容都是作为数据内容存在的    
			<xx>aa</xx>    
			<xx>    aa   </xx>    
		6.特殊字符必须转义    
			< > &     
		满足上面规范的文件我们称之为是一个格式良好的xml文件.可以通过浏览器浏览    
	后缀名:    
		.xml    
xml组成部分:    
	声明:     
		作用:告诉别人我是一个xml文件    
		格式:  	  
			<?xml .....  ?>    
		例如:    
			<?xml version="1.0" encoding="UTF-8"?>    
			<?xml version='1.0' encoding='utf-8' standalone="yes|no"?>    
		要求:    
			必须在xml文件的第一行    
			必须顶格写    
	元素(标签):    
		格式:    
			<xx></xx>    
			<xx/>    
		要求:    
			1.必须关闭    
			2.标签名不能 xml Xml XML 等等开头    
			3.标签名中不能出现" "或者":"等特殊字符.    
	属性:    
		格式:    
			<xx 属性名="属性值"/>    
		要求:    
			属性必须用引号引起来    
	注释:    
		和html一样    
		<!-- 注释内容 -->    
	CDATA:    
		xml文件的特殊字符必须转义    
		通过cdataky 保证数据原样输出    
			格式:    
				<![CDATA[    
					原样输出的内容    
				]]>    
    
xml解析:    
	解析方式:    
		1.sax:特点:逐行解析,只能查询.     
		2.dom:特点:一次性将文档加载到内容中,形成一个dom树.可以对dom树curd操作  
	解析技术:    
		JAXP：sun公司提供支持DOM和SAX开发包    
		JDom：dom4j兄弟    
		jsoup：一种处理HTML特定解析开发包    
		★dom4j：比较常用的解析开发包，hibernate底层采用。    
	dom4j技术进行查询操作.    
		使用步骤:    
			1.导入jar包    
			2.创建一个核心对象 SAXReader    
				new SAXReader();    
			3.将xml文档加载到内存中形成一棵树    
				Document doc=reader.read(文件)    
			4.获取根节点    
				Element root=doc.getRootElement();      
			5.通过根节点就可以获取其他节点(文本节点,属性节点,元素节点)    
				获取所有的子元素    
					List<Element> list=root.elements()     
				获取元素的指定属性内容    
					String value=root.attributeValue("属性名");    
				获取子标签标签体:遍历list 获取到每一个子元素    
					String text=ele.elementText("子标签名称")    
	
	
	
	
				
	
	
	
				
		
				
	xpath解析技术:(扩展)  
		依赖于dom4j  
			使用步骤:  
				1.导入jar包(dom4j和jaxen-1.1-beta-6.jar)  
				2.加载xml文件到内存中  
				3.使用api  
					selectNode("表达式");  
					selectSingleNode("表达式");  
			表达式的写法:  
				/ 从根节点选取   
				// 从匹配选择的当前节点选择文档中的节点，而不考虑它们的位置   
				例如一个标签下有一个id属性且有值  id=2;  
					//元素名[@属性名='属性值']  
					//元素名[@id='2']    
				
    
反射:  
	1.获取对应的class对象  
		方式1:★  
			Class clazz=Class.forName("全限定名");  
		方式2:  
			Class clazz=类名.class;  
		方式3:  
			Class clazz==对象.getClass();  
	2.通过class对象创建一个实例对象(相当于  new 类())  
		Object clazz.newInstance();  
	3.通过class对象获取一个方法(public修饰的)  
		Method method=clazz.getMethod("方法名",Class .... paramType);  
			paramType为参数的类型  
	4.让方法执行:  
		method.invoke(Object 实例对象,Object ... 参数);  
			Object 实例对象:以前调用方法的对象 就是a  
			Object ... 参数:该方法运行时需要的参数 就是 10和30  
		执行这个方法 相当于  
			a.add(10,30);  
		例如:  
			method.invoke(a,10,30)  
    
xml约束:  
	作用:规定xml中可以出现那些元素及那些属性,以及他们出现的顺序.  
	约束的分类:  
		DTD约束:struts hiebernate等等  
		SCHEMA约束:tomcat spring等等  
    
DTD约束:  
	和xml的关联	(一般都会提供好,复制过来即可,有时候连复制都不需要.)  
		方式1:内部关联  
			格式:  
				<!DOCTYPE 根元素名 [dtd语法]>  
		方式2:外部关联-系统关联  
			格式:  
				<!DOCTYPE 根元素名 SYSTEM "约束文件的位置">   
			例如:  
				<!DOCTYPE web-app SYSTEM "web-app_2_3.dtd">  
		方式3:外部关联-公共关联  
			格式:  
				<!DOCTYPE 根元素名 PUBLIC "约束文件的名称" "约束文件的位置">  
  
dtd语法(了解)  
	元素:  
		<!Element 元素名称 数据类型|包含内容>  
			数据类型:  
				#PCDATA:普通文本 使用的时候一般用()引起来  
			包含内容:  
				该元素下可以出现那些元素 用()引起来  
		符号:  
			*	出现任意次  
			?	出现1次或者0次  
			+	出现至少1次  
			|	或者  
			()  分组  
			,	顺序  
				
	属性:  
		格式:  
			<!ATTLIST 元素名 属性名 属性类型 属性是否必须出现>  
		属性类型:  
			ID:唯一  
			CDATA:普通文本  
		属性是否必须出现  
			REQUIRED:必须出现  
			IMPLIED:可以不出现  
	
	一个xml文档中只能添加一个DTD约束  
xml的学习目标:  
	编写一个简单的xml文件  
	可以根据约束文件写出相应xml文件.  
		按f2或者 alt+/提示写出内容即可  
    
SCHEMA约束:  
	一个xml文档中可以添加多个schema约束  
	xml和schema的关联.  
		格式:  
			<根标签 xmlns="..." ...>  
			<根标签 xmlns:别名="..." ...>  
	名称空间:  
		关联约束文件  
		规定元素是来源于那个约束文件的  
	例如:  
		一个约束文件中规定 table(表格)  表格有属性 row和col  
		还有一个约束文件规定 table(桌子) 桌子有属性 width和height  
		
		在同一个xml中万一我把两个约束文件都导入了,  
			在xml中我写一个table,这个table有什么属性????  
		我们为了避免这种情况的发生,可以给其中的一个约束起个别名  
		使用的时候若是没有加别名那就代表是来自于没有别名的约束文件  
			例如 table(表格) 给他起个别名  xmlns:a="..."  
			在案例中使用 a:table 代表的是表格  
			若在案例中直接使用 table 代表的是桌子  
		在一个xml文件中只能有一个不起别名;  
注意:  
	schema约束本身也是xml文件.    
	
  	  
### 案例2-通过eclipse能发布自己的项目.  
#### 技术分析:    
	eclipse:ide    
	tomcat:服务器  
	项目:web项目    
    
服务器:  
	硬件服务器和软件服务器  
web服务器:  
	提供资源供别人访问  
web:  
	网页的意思,资源.  
web资源分类:  
	动态的web资源:内容有可能发生改变的  
	静态的web资源:内容是一成不变的.(几乎看不到)
web开发技术:  
	动态的web开发技术:servlet jsp php .net  
	静态的web开发技术:html css ....  
什么叫javaweb  
	通过java语言编写的网页称之为javaweb  
web通信机制:  
	基于请求响应机制.     
	一次请求一次响应,先有请求后有响应
常见的web服务器:  

| 服务器名称  |  厂商  |  特点  |
| ------ | ------ | ------ | 
| weblogic | oracle | 大型的收费的支持javaee所有规范的服务器 |
| webspere | IBM | 大型的收费的支持javaee所有规范的服务器 |
| tomcat | apache组织 | 中小型的免费的支持servlet和jsp规范的服务器 |
	
  
#### tomcat:  
	下载:  
		.tar .tar.gz: 提供给linux系统  
		.zip .exe:提供给window系统  
	安装:  
		解压apache-tomcat-7.0.52.zip即可  
		
	启动:  
		tomcat/bin目录下  
		双击 startup.bat  
		打开浏览器:  
			http://localhost:8080  
	退出:  
		方式1:点 x  
		方式2:ctrl+c  
		方式3:双击 shutdown.bat
			
	常见问题(配置):
		1.启动的时候一闪而过 	正确配置:JAVA_HOME
		2.端口冲突问题
			修改tomcat的端口号.
				打开tomcat/conf/server.xml
				大概70行左右 有如下代码:
					 <Connector port="8080" protocol="HTTP/1.1"
						   connectionTimeout="20000"
						   redirectPort="8443" />
				修改port后面的值就可以了.注意:1024以下的端口号留给系统用的
				80端口是留给http协议用的.我们可以使用这个端口号
		3.有可能出现的问题(在环境变量中配置CATALINA_HOME)  
			删除  

	tomcat目录结构:(了解)
		bin:存放的可执行程序
		conf:配置文件
		lib:存放的是tomcat和项目运行时需要的jar包
		logs:日志 注意:catalina
		temp:临时文件
		★★webapps:存放项目的目录
		★work:存放jsp文件在运行时产生的java和class文件  

	web项目的目录结构:★★★
		myweb(项目名称)   web2.5版本标准的目录结构
			|
			|---- html css js image等目录或者文件
			|
			|---- WEB-INF(特点:通过浏览器直接访问不到 目录)
			|	 	|
			|	 	|--- lib(项目的第三方jar包)
			|	 	|--- classes(存放的是我们自定义的java文件生成的.class文件)
			|	 	|--- web.xml(当前项目的核心配置文件)
			|	 	|
	
	访问路径:
		http://主机:端口号/项目名称/资源路径
		例如:我的项目 myweb 
			资源 myweb有一个1.html
		http://localhost:80/myweb/1.html  

	常用的项目发布方式:(虚拟目录映射)
		★方式1:将项目放到tomcat/webapps下
		(了解)方式2:修改 tomcat/conf/server.xml
			大概130行:
				在host标签下 添加如下代码
					<Context path="/项目名" docBase="项目的磁盘目录"/>
				例如:
					<Context path="/my" docBase="G:\myweb"/>
		(了解)方式3:
			在tomcat/conf/引擎目录/主机目录下 新建一个xml文件
				文件的名称就是项目名 文件的内容如下:
					<Context docBase="G:\myweb"/>  

	eclipse和tomcat的整合★ ★
		参考 day08.xls或者 day08.doc文档
	
	通过eclipse发布项目
		1.创建一个项目(动态的web项目)
		2.选择web项目的版本为 2.5( 若版本为3.0目录下没有web.xml)
		3.java文件在src目录下
		  网页或者图片放在webcontent
		4.发布项目		
		参考	

### 上午回顾:  
xml:  
	可扩展的标签语言  
	作用:  
		配置文件.  
约束:  
	用来控制xml文档中可以出现那些元素和属性,以及他们出现的顺序  
分类:  
	DTD约束:struts hiebernate   
	SCHEMA约束:tomcat 项目 spring    
  

dtd约束:  
	1.会和xml关联.  
	2.可以通过约束写出xml文件  
		按f2或者alt+/  
		? * + | () ,  
注意:  
	一个xml只能出现一个dtd约束    
  
SCHEMA:  
	一个xml文件中可以出现多个schema约束  
	通过名称空间将约束添加的    
		xmlns="名称空间"   
		xmlns:别名="名称空间"      
  

xml-解析  
	dom:一次性将整个xml文件加载到内存.可以curd操作  
	sax:逐行解析  只能进行查询操作  
dom4j技术查询xml  
	1.导入jar包  
	2.获取document树  
		Document doc=new SAXReader().read(xml文件路径);
	3.获取根节点  
		Element root= doc.getRootElement();  
	4.通过根节点获取其他节点  
		获取属性节点   
			String value=root.attributeValue("属性名");    
		获取所有的子元素    
			List<Element> list=root.elements();    
		获取一个元素的子元素的标签体    
			String text=ele.elementText("子元素");    
	Xpath:扩展:    
		selectNodes("") 获取多个    
		selectSingleNode("") 获取一个      
		  
    
反射:  
	1.获取class对象  
		方式3:  
			Class clazz=Class.forName("全限定名");// 包名+类名   com.mysql.jdbc.Driver  
	2.通过class对象创建一个实例对象  
		clazz.newInstance();//相当于调用此类的无参构造  
	
	3.获取方法(public修饰的方法)  
		Method m=clazz.getMethod("方法名称",Class ... 参数类型);  
	4.执行方法  
		m.invoke(实例对象,参数...);//相当于   实力对象.m(参数...)  
		  

web的概念  
	web:网页  
	web资源:  
		动态和静态  
	web开发技术  
	常见的服务器  
	tomcat:★  
		下载 安装 启动  退出  配置 目录  
	web项目的目录结构★  
	web项目发布:  
		方式1:放在tomcat/webapps下  
	eclipse和tomcat整合  
	在eclipse发布项目  


