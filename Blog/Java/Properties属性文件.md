## Properties属性文件

### 1.Properties与ResourceBundle
两个类都可以读取属性文件中以key/value形式存储的键值对，ResourceBundle读取属性文件时操作相对简单。

### 2.Properties
该类继承Hashtable，将键值对存储在集合中。基于输入流从属性文件中读取键值对，load()方法调用完毕，就与输入流脱离关系，不会自动关闭输入流，需要手动关闭。
复制代码
```
    /**
     * 基于输入流读取属性文件：Properties继承了Hashtable，底层将key/value键值对存储在集合中，
     * 通过put方法可以向集合中添加键值对或者修改key对应的value
     * 
     * @throws IOException
     */
    @SuppressWarnings("rawtypes")
    @Test
    public void test01() throws IOException {
        FileInputStream fis = new FileInputStream("Files/test01.properties");
        Properties props = new Properties();
        props.load(fis);// 将文件的全部内容读取到内存中，输入流到达结尾
        fis.close();// 加载完毕，就不再使用输入流，程序未主动关闭，需要手动关闭

        /*byte[] buf = new byte[1024];
        int length = fis.read(buf);
        System.out.println("content=" + new String(buf, 0, length));//抛出StringIndexOutOfBoundsException*/

        System.out.println("driver=" + props.getProperty("jdbc.driver"));
        System.out.println("url=" + props.getProperty("jdbc.url"));
        System.out.println("username=" + props.getProperty("jdbc.username"));
        System.out.println("password=" + props.getProperty("jdbc.password"));

        /**
         * Properties其他可能用到的方法
         */
        props.put("serverTimezone", "UTC");// 底层通过hashtable.put(key,value)
        props.put("jdbc.password", "456");
        FileOutputStream fos = new FileOutputStream("Files/test02.xml");// 将Hashtable中的数据写入xml文件中
        props.storeToXML(fos, "来自属性文件的数据库连接四要素");

        System.out.println();
        System.out.println("遍历属性文件");
        System.out.println("hashtable中键值对数目=" + props.size());
        Enumeration keys = props.propertyNames();
        while (keys.hasMoreElements()) {
            String key = (String) keys.nextElement();
            System.out.println(key + "=" + props.getProperty(key));
        }

    }
    
```

### 3.ResourceBundle
该类基于类读取属性文件：将属性文件当作类，意味着属性文件必须放在包中，使用属性文件的全限定性类名而非路径指代属性文件。
复制代码
```
    /**
     * 基于类读取属性文件：该方法将属性文件当作类来处理，属性文件放在包中，使用属性文件的全限定性而非路径来指代文件
     */
    @Test
    public void test02() {
        ResourceBundle bundle = ResourceBundle.getBundle("com.javase.properties.test01");
        System.out.println("获取指定key的值");
        System.out.println("driver=" + bundle.getString("jdbc.driver"));
        System.out.println("url=" + bundle.getString("jdbc.url"));
        System.out.println("username=" + bundle.getString("jdbc.username"));
        System.out.println("password=" + bundle.getString("jdbc.password"));

        System.out.println("-----------------------------");
        System.out.println("遍历属性文件");
        Enumeration<String> keys = bundle.getKeys();
        while (keys.hasMoreElements()) {
            String key = keys.nextElement();
            System.out.println(key + "=" + bundle.getString(key));
        }
    }
```

### 4.读取属性文件到Spring容器
通常将数据库连接四要素放在属性文件中，程序从属性文件中读取参数，这样当数据库连接要素发生改变时，不需要修改源代码。将属性文件中的内容加载到xml文档中的方法：
```
    在配置文件头配置context约束。
    在配置文件中加入<context:property-placeholder loacation="classpath:xxxxxx"/>，加载属性到配置文件中。
    获取配置文件内容：${key}
```
### 5.注释
`#放在前面，用于在属性文件中添加注释。`

### 6.编码
属性文件采用ISO-8859-1编码方式，该编码方式不支持中文，中文字符将被转化为Unicode编码方式显示。

