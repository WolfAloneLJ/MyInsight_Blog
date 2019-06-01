## Tomcat


#### Web相关概念
1.WEB  

在英语中web即表示网页的意思，它用于表示Internet主机上供外界访问的资源。  
Internet上供外界访问的Web资源分为：  
静态web资源（如html 页面）：指web页面中供人们浏览的数据始终是不变。  
动态web资源：指web页面中供人们浏览的数据是由程序产生的，不同时间点访问web页面看到的内容各不相同。  

静态web资源开发技术：Html  
常用动态web资源开发技术：JSP/Servlet、ASP、PHP等  
在Java中，动态web资源开发技术统称为Javaweb，我们课程的重点也是教大家如何使用Java技术开发动态的web资源，即动态web页面。  


2.CS与BS结构  

C/S结构:  
即Client/Server (客户端/服务器) 结构，是大家熟知的软件系统体系结构，通过将任务合理分配到Client端和Server端，降低了系统的通讯开销，需要安装客户端才可进行管理操作。
客户端和服务器端的程序不同，用户的程序主要在客户端，服务器端主要提供数据管理、数据共享、数据及系统维护和并发控制等，客户端程序主要完成用户的具体的业务。
开发比较容易，操作简便，但应用程序的升级和客户端程序的维护较为困难。  
B/S结构:  
即Browser/Server (浏览器/服务器) 结构，是随着Internet技术的兴起，对C/S结构的一种变化或者改进的结构。
在这种结构下，用户界面完全通过WWW浏览器实现。客户端基本上没有专门的应用程序，应用程序基本上都在服务器端。
由于客户端没有程序，应用程序的升级和维护都可以在服务器端完成，升级维护方便。  

3.Web开发如何通信  



#### Web服务器介绍
WebLogic是美国Oracle公司出品的一个application server，确切的说是一个基于JAVAEE架构的中间件，WebLogic是用于开发、集成、部署和管理大型分布式Web应用、网络应用和数据库应用的Java应用服务器。
将Java的动态功能和Java Enterprise标准的安全性引入大型网络应用的开发、集成、部署和管理之中。
WebLogic是美商Oracle的主要产品之一，系并购BEA得来。
是商业市场上主要的Java（J2EE）应用服务器软件（application server）之一，是世界上第一个成功商业化的J2EE应用服务器, 已推出到12c(12.1.3) 版。
  
WebSphere 是 IBM 的软件平台。
它包含了编写、运行和监视全天候的工业强度的随需应变 Web 应用程序和跨平台、跨产品解决方案所需要的整个中间件基础设施，如服务器、服务和工具。
WebSphere 提供了可靠、灵活和健壮的软件。
WebSphere Application Server 是该设施的基础，其他所有产品都在它之上运行，支持JAVAEE规范  

Tomcat是Apache 软件基金会（Apache Software Foundation）的Jakarta 项目中的一个核心项目，由Apache、Sun 和其他一些公司及个人共同开发而成。
由于有了Sun 的参与和支持，最新的Servlet 和JSP 规范总是能在Tomcat 中得到体现，Tomcat 5支持最新的Servlet 2.4 和JSP 2.0 规范。因为Tomcat 技术先进、性能稳定，而且免费，因而深受Java 爱好者的喜爱并得到了部分软件开发商的认可，成为目前比较流行的Web 应用服务器。
目前最新版本是8.0。Tomcat 服务器是一个免费的开放源代码的Web 应用服务器，属于轻量级应用服务器，在中小型系统和并发访问用户不是很多的场合下被普遍使用，是开发和调试JSP 程序的首选,它还是一个Servlet和JSP容器


#### Tomcat的安装与目录介绍  
1.Tomcat安装  

2.Tomcat测试  

3.Tomcat安装相关问题


4.Tomcat退出  

5.Tomcat目录结构  


#### Web的目录介绍
开发web应用时，不同类型的文件有严格的存放规则，否则不仅可能会使web应用无法访问，还会导致web服务器启动报错。  

#### 发布Web应用至Tomcat








