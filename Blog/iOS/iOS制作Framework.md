##  iOS的Framework制作

### 什么是库?
库是共享程序代码的方式。  
库从本质上来说是一种可执行代码的二进制格式，可以被载入内存中执行。库分静态库和动态库两种。  
iOS中的静态库有 .a 和 .framework两种形式；动态库有.dylib 和 .framework 形式，后来.dylib动态库又被苹果替换成.tbd的形式。  

### 静态库与动态库的区别
静态库:  链接时完整地拷贝至可执行文件中，被多次使用就有多份冗余拷贝。
动态库:链接时不复制，程序运行时由系统动态加载到内存，供程序调用，系统只加载一次，多个程序共用，节省内存。[ios暂时只允许使用系统动态库]；  

静态库和动态库是相对编译期和运行期的：静态库在程序编译时会被链接到目标代码中，程序运行时将不再需要改静态库；而动态库在程序编译时并不会被链接到目标代码中，只是在程序运行时才被载入，因为在程序运行期间还需要动态库的存在。  
总结：同一个静态库在不同程序中使用时，每一个程序中都得导入一次，打包时也被打包进去，形成一个程序。而动态库在不同程序中，打包时并没有被打包进去，只在程序运行使用时，才链接载入（如系统的框架如UIKit、Foundation等），所以程序体积会小很多，但是苹果不让使用自己的动态库，否则审核就无法通过。  

### iOS里静态库和动态库的形式
静态库: .a和.framework  
动态库: .dylib和.framework

### framework为什么既是静态库又是动态库？
系统的.framework是动态库，我们自己建立的.framework是静态库。   

### a与.framework有什么区别？
.a是一个纯二进制文件，.framework中除了有二进制文件之外还有资源文件。  
.a文件不能直接使用，至少要有.h文件配合，.framework文件可以直接使用。  
.a + .h + sourceFile = .framework。  
建议用.framework.  

### 为什么要使用静态库?
方便共享代码，便于合理使用。  
实现iOS程序的模块化。可以把固定的业务模块化成静态库。  
和别人分享你的代码库，但不想让别人看到你代码的实现。  
开发第三方sdk的需要。  


### 制作静态库的几点注意:
* 1.注意理解：无论是.a静态库还.framework静态库，我们需要的都是二进制文件+.h+其它资源文件的形式，不同的是，.a本身就是二进制文件，需要我们自己配上.h和其它文件才能使用，而.framework本身已经包含了.h和其它文件，可以直接使用。  
* 2.图片资源的处理：两种静态库，一般都是把图片文件单独的放在一个.bundle文件中，一般.bundle的名字和.a或.framework的名字相同。.bundle文件很好弄，新建一个文件夹，把它改名为.bundle就可以了，右键，显示包内容可以向其中添加图片资源。  
* 3.category是我们实际开发项目中经常用到的，把category打成静态库是没有问题的，但是在用这个静态库的工程中，调用category中的方法时会有找不到该方法的运行时错误（selector not recognized），解决办法是：在使用静态库的工程中配置other linker flags的值为-ObjC。  
* 4.如果一个静态库很复杂，需要暴露的.h比较多的话，就可以在静态库的内部创建一个.h文件（一般这个.h文件的名字和静态库的名字相同），然后把所有需要暴露出来的.h文件都集中放在这个.h文件中，而那些原本需要暴露的.h都不需要再暴露了，只需要把.h暴露出来就可以了。  


### 创建.a静态库


### 创建.framework静态库



### FrameWork里面使用StoryBoard、图片



### 经典报错
 找不到符号在XX架构上  
`Undefined symbols for architecture x86_64(armv7/armv7s/amr64/i386)`

### 架构的分类
 一、模拟器架构:2种  
 
       i386   : 32位架构  4S ~ 5  
       x86_64 : 64位架构   5S ~ 现在的机型  

 二、真机架构: 3种

        armv7 : 32位架构    3GS ~ 4S  
        armv7s: 特殊的架构   5 ~ 5C   (此架构有问题, 有的程序变得更快, 有的程序变得更慢)  
        amr64 : 64位架构    5S ~ 现在的机型  

 

 64位/32位: 内存寻址不同





### 参考
[iOS封装功能生成 .framework](https://www.cnblogs.com/oc-bowen/p/7478461.html)       
[iOS Framework制作流程](https://www.jianshu.com/p/f2bb038db637)  
[iOS开发中静态库之".framework静态库"的制作及使用篇](https://www.cnblogs.com/mtystar/p/6083288.html)  


引用OC库可以通过  
[优雅的开发Swift和Objective C混编的Framework](https://blog.csdn.net/hello_hwc/article/details/58320433)  
[iOS打包framework - Swift完整项目打包Framework，嵌入OC项目使用](https://www.cnblogs.com/yajunLi/p/5987687.html)  
[iOS 完整项目制作Framework ](https://www.jianshu.com/p/7452db9e37bd)  
[iOS Framework制作流程](https://www.jianshu.com/p/f2bb038db637)  

[原创：iOS 打包.framework(包括第三方、图片、xib、plist文件)](https://www.jianshu.com/p/e056fde1be17)

### 架构
[iOS armv7, armv7s, arm64区别与应用32位、64位配置](https://www.jianshu.com/p/567d3b730608)  
[iOS armv7,armv7s, arm64](https://blog.csdn.net/qcx321/article/details/81871778)  
[Xcode 6制作动态及静态通用Framework（解决不支持 armv7s arm64 armv7）](https://blog.csdn.net/hcb1230/article/details/43530765)  
[iOS开发～制作同时支持armv7,armv7s,arm64,i386,x86_64的静态库.a以及 FrameWork 的创建](https://www.cnblogs.com/lurenq/p/7068468.html)  

### 设置版本号
[设置Framework版本号](https://blog.csdn.net/MerryGOOT/article/details/54600134)  

[在iOS开发中，给项目添加新的.framework](https://www.cnblogs.com/JuneWang/p/4860987.html)  
[iOS封装功能生成 .framework](https://www.cnblogs.com/oc-bowen/p/7478461.html)  
[ios 发布framework 到cocoapods](https://www.jianshu.com/p/c72914c3446b) 
[上传iOS Framework到CocoaPods](https://www.jianshu.com/p/954646c47068)  

[【转】iOS静态库 【.a 和framework】【超详细】](https://blog.csdn.net/weixin_34026276/article/details/86228593)  
[iOS开发-如何判断framework是动态库或静态库以及framework静态库转.a静态库](https://www.jianshu.com/p/77343def4574)  
