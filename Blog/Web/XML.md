## XML基础知识

注意事项:
xml必须有根元素(只有一个)  
xml标签必须有关闭标签  
xml标签对大小写敏感  
xml的属性值须加引号  
特殊字符必须转义  
xml中的标签名不能有空格  
空格/回车/制表符在xml中都是文本节点  
xml必须正确地嵌套




```
<bookstore>
<book category="COOKING">
    <title lang="en">Everyday Italian</title>
    <author>Giada De Laurentiis</author>
    <year>2005</year>
    <price>30.00</price>
</book>
<book category="CHILDREN">
    <title lang="en">Harry Potter</title>
    <author>J K. Rowling</author>
    <year>2005</year>
    <price>29.99</price>
</book>
<book category="WEB">
    <title lang="en">Learning XML</title>
    <author>Erik T. Ray</author>
    <year>2003</year>
    <price>39.95</price>
</book>
</bookstore>
```


#### XML约束介绍  
约束XML编写什么样的内容  
XML的约束有两种
    DTD约束和SCHEMA约束  
应用:  
    DTD：struts、hibernate等  
	Schema：web项目、spring等  



#### XML约束--DTD  
入门案例   



#### XML约束--SCHEMA  

入门案例  


名称空间  



元素  

属性  


### XML解析 
1.XML解析介绍  


2.Dom4j介绍与查询操作  


3.dom4j-xpath使用










