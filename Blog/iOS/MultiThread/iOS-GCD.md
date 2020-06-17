### GCD

#### 优先级
从ios8开始，苹果引入了一个新的概念 QoS（quality of service），用于指定GCD队列的优先级。  
swift3之前：只有4个优先级  
`high > default > low > background`  
swift3之后：调整为6个优先级  
`userInteractive > default > unspecified > userInitiated > utility > background`  
`其中：userInteractive优先级最高，background最低`  

 

现有和之前的大概对应关系：

* DISPATCH_QUEUE_PRIORITY_HIGH:         .userInteractive
* DISPATCH_QUEUE_PRIORITY_DEFAULT:      .default
* DISPATCH_QUEUE_PRIORITY_LOW:          .utility
* DISPATCH_QUEUE_PRIORITY_BACKGROUND:   .background


```swift
for i in 1...10 {
       DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
           NSLog("DispatchQoS.QoSClass.default, %d", i)
       }
            
       DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
           NSLog("DispatchQoS.QoSClass.background, %d", i)
       }
            
       DispatchQueue.global(qos: DispatchQoS.QoSClass.unspecified).async {
           NSLog("DispatchQoS.QoSClass.unspecified, %d", i)
       }
            
       DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
           NSLog("DispatchQoS.QoSClass.userInitiated, %d", i)
       }
            
       DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
           NSLog("DispatchQoS.QoSClass.userInteractive, %d", i)
       }
            
       DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
           NSLog("DispatchQoS.QoSClass.utility, %d", i)
       }
}
```




#### 参考
[Swift3.0 GCD多线程详解](https://blog.csdn.net/brycegao321/article/details/53898919)  
[Swift多线程：使用GCD实现异步下载图片](http://www.cocoachina.com/articles/20065)  
[iOS多线程及异步处理](https://blog.csdn.net/guobing19871024/article/details/62422648)  
[Swift 3.0中GCD的常用方法](https://blog.csdn.net/hmh007/article/details/52953273)  
[[Swift]多线程--GCD](https://www.jianshu.com/p/bd1336c18aa3)  
[Swift4 - GCD的使用](https://blog.csdn.net/longshihua/article/details/79756676)  
[swift---GCD的基本使用](https://blog.csdn.net/wujakf/article/details/98502738)  

[dispatch_async 与 dispatch_get_global_queue 区别](https://www.jianshu.com/p/ff4a2ea7021e)  


[iOS多线程(手把手教你进阶)](https://www.jianshu.com/p/a26e46d04b32) 

[Swift3 GCD队列优先级说明](https://www.cnblogs.com/yajunLi/p/7145469.html?utm_source=itdadao&utm_medium=referral)  
[Swift5 多线程 - GCD](https://www.jianshu.com/p/1dac29186e18)  
[iOS多线程-队列优先级](https://www.jianshu.com/p/c2a7a4e19772)  
