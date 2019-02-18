##  OC-多线程(MultiThread)

###


### GCD

从Swift3开始GCD的API就发生了很大的变化，更加简洁，使用起来更方便。像我们经常开启一个异步线程处理事情然后切回主线程刷新UI操作，这里就变的非常简单了。
```
    DispatchQueue.global().async {
         // do async task
         DispatchQueue.main.async {
             // update UI
          }
      }
```
     

DispatchQueue

DispatchQueue字面意思就是派发列队，主要是管理需要执行的任务，任务以闭包或者DispatchWorkItem的方式进行提交.列队中的任务遵守FIFO原则。如果对于列队不是很了解，可以看[这里](https://blog.csdn.net/longshihua/article/details/50523051)。 列队可以是串行也可以是并发，串行列队按顺序执行，并发列队会并发执行任务，但是我们并不知道具体任务的执行顺序。
列队的分类  
系统列队  
主列队  
```
let mainQueue = DispatchQueue.main
```
全局列队  
```
let globalQueue = DispatchQueue.global()
```
用户创建列队  
创建自己的列队，简单的方式就是指定列队的名称即可   
```
let queue = DispatchQueue(label: "com.conpanyName.queue")
```

这样的初始化的列队有着默认的配置项,默认的列队是串行列队。便捷构造函数如下
```
public convenience init(label: String, qos: DispatchQoS = default, attributes: DispatchQueue.Attributes = default, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = default, target: DispatchQueue? = default)
```
我们也可以自己显示设置相关属性，创建一个并发列队
```
    let label = "com.conpanyName.queue"
    let qos = DispatchQoS.default
    let attributes = DispatchQueue.Attributes.concurrent
    let autoreleaseFrequnecy = DispatchQueue.AutoreleaseFrequency.never
    let queue = DispatchQueue(label: label, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequnecy, target: nil)
```
参数介绍

label：列队的标识符，能够方便区分列队进行调试

qos：列队的优先级（quality of service），其值如下：
```
       public struct DispatchQoS : Equatable {
            public static let background: DispatchQoS
            public static let utility: DispatchQoS
            public static let `default`: DispatchQoS
            public static let userInitiated: DispatchQoS
            public static let userInteractive: DispatchQoS
            public static let unspecified: DispatchQoS
       }
```
优先级由最低的background到最高的userInteractive共五个，还有一个为定义的unspecified. 

background：最低优先级，等同于DISPATCH_QUEUE_PRIORITY_BACKGROUND. 用户不可见，比如：在后台存储大量数据

utility：优先级等同于DISPATCH_QUEUE_PRIORITY_LOW，可以执行很长时间，再通知用户结果。比如：下载一个大文件，网络，计算

default：默认优先级,优先级等同于DISPATCH_QUEUE_PRIORITY_DEFAULT，建议大多数情况下使用默认优先级

userInitiated：优先级等同于DISPATCH_QUEUE_PRIORITY_HIGH,需要立刻的结果

.userInteractive：用户交互相关，为了好的用户体验，任务需要立马执行。使用该优先级用于UI更新，事件处理和小工作量任务，在主线程执行。

Qos指定了列队工作的优先级，系统会根据优先级来调度工作，越高的优先级能够越快被执行，但是也会消耗功能，所以准确的指定优先级能够保证app有效的使用资源。详细可以看这里

attributes：列队的属性，也可以说是类型，即是并发还是串行。attributes是一个结构体并遵守OptionSet协议，所以传入的参数可以为[.option1, .option2]

```
     public struct Attributes : OptionSet {
          public let rawValue: UInt64
          public init(rawValue: UInt64)
          public static let concurrent: DispatchQueue.Attributes
          public static let initiallyInactive: DispatchQueue.Attributes
     }

```
默认：列队是串行的

.concurrent：列队是并发的

.initiallyInactive：列队不会自动执行，需要开发中手动触发

autoreleaseFrequency：自动释放频率，有些列队会在执行完任务之后自动释放，有些是不会自动释放的，需要手动释放。

简单看一下列队优先级

```
     DispatchQueue.global(qos: .background).async {
         for i in 1...5 {
             print("background: \(i)")
         }
     }
     DispatchQueue.global(qos: .default).async {
         for i in 1...5 {
             print("default: \(i)")
         }
    }
    DispatchQueue.global(qos: .userInteractive).async {
         for i in 1...5 {
             print("userInteractive: \(i)")
         }
    }
```
    执行结果：
```
            default: 1
            userInteractive: 1
            background: 1
            default: 2
            userInteractive: 2
            background: 2
            userInteractive: 3
            default: 3
            userInteractive: 4
            userInteractive: 5
            default: 4
            background: 3
            default: 5
            background: 4
            background: 5
```

DispatchWorkItem

DispatchWorkItem是用于帮助DispatchQueue来执行列队中的任务。类的相关内容如下：

```
     public class DispatchWorkItem {
          public init(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, block: @escaping @convention(block) () -> Swift.Void)
          public func perform()
          public func wait()
          public func wait(timeout: DispatchTime) -> DispatchTimeoutResult
          public func wait(wallTimeout: DispatchWallTime) -> DispatchTimeoutResult
          public func notify(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, queue: DispatchQueue, execute: @escaping @convention(block) () -> Swift.Void)
          public func notify(queue: DispatchQueue, execute: DispatchWorkItem)
          public func cancel()
          public var isCancelled: Bool { get }
     }
```

一般情况下，我们开启一个异步线程，会这样创建列队并执行async方法，以闭包的方式提交任务。
```
     DispatchQueue.global().async {
         // do async task
     }

```
但是Swift3中使用了DispatchWorkItem类将任务封装成为对象，由对象进行任务。
```
     let item = DispatchWorkItem {
          // do task
     }
     DispatchQueue.global().async(execute: item)
```
当然，这里也可以使用DispatchWorkItem实例对象的perform方法执行任务

```
     let workItem = DispatchWorkItem {
         // do task
     }
     DispatchQueue.global().async {
        workItem.perform()
     }
```

但是对比一下两种方式，显然第一种更加简洁，方便。

执行任务结束通过nofify获得通知

```
     let workItem = DispatchWorkItem {
         // do async task
         print(Thread.current)
     }
     
     DispatchQueue.global().async {
         workItem.perform()
     }
     
     workItem.notify(queue: DispatchQueue.main) {
         // update UI
         print(Thread.current)
     }

```
使用wait等待任务执行完成

```
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    let workItem = DispatchWorkItem {
        sleep(5)
        print("done")
    }
     
    queue.async(execute: workItem)
    print("before waiting")
    workItem.wait()
    print("after waiting")
```     
执行结果：
```
            before waiting
            done
            after waiting
```
也可以在初始化的时候指定更多的参数
```
     let item = DispatchWorkItem(qos: .default, flags: .barrier) {
         // do task
     }
```
第一个参数同样说优先级，第二个参数指定flag
```
         public struct DispatchWorkItemFlags : OptionSet, RawRepresentable {
         public let rawValue: UInt
         public init(rawValue: UInt)
         public static let barrier: DispatchWorkItemFlags
         public static let detached: DispatchWorkItemFlags
         public static let assignCurrentContext: DispatchWorkItemFlags
         public static let noQoS: DispatchWorkItemFlags
         public static let inheritQoS: DispatchWorkItemFlags
         public static let enforceQoS: DispatchWorkItemFlags
     }
```
barrier

假如我们有一个并发的列队用来读写一个数据对象，如果这个列队的操作是读，那么可以同时多个进行。如果有写的操作，则必须保证在执行写操作时，不会有读取的操作执行，必须等待写操作完成之后再开始读取操作，否则会造成读取的数据出错，经典的读写问题。这里我们就可以使用barrier：
```
    let item = DispatchWorkItem(qos: .default, flags: .barrier) {
        // write data
    }
    let dataQueue = DispatchQueue(label: "com.data.queue", attributes: .concurrent)
    dataQueue.async(execute: item)
```
字典的读写操作
```
     private let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
     private var dictionary: [String: Any] = [:]
     
     public func set(_ value: Any?, forKey key: String) {
         // .barrier flag ensures that within the queue all reading is done
         // before the below writing is performed and
         // pending readings start after below writing is performed
         concurrentQueue.async(flags: .barrier) {
              self.dictionary[key] = value
         }
     }
     
     public func object(forKey key: String) -> Any? {
         var result: Any?
         concurrentQueue.sync {
             result = dictionary[key]
         }
     
         // returns after concurrentQueue is finished operation
         // beacuse concurrentQueue is run synchronously
         return result
     }
```
通过在并发代码中使用barrier将能够保证写操作在所有读取操作完成之后进行，而且确保写操作执行完成之后再开始后续的读取操作。具体的详情看这里


延时处理

使用asyncAfter来提交任务进行延迟。之前是使用dispatch_time,现在是使用DispatchTime对象表示。可以使用静态方法now获得当前时间，然后再通过加上DispatchTimeInterval枚举获得一个需要延迟的时间。注意：仅仅是用于在具体时间执行任务，不要在资源竞争的情况下使用。并且在主列队使用。

```
     let delay = DispatchTime.now() + DispatchTimeInterval.seconds(10)
     DispatchQueue.main.asyncAfter(deadline: delay) {
         // 延迟执行
     } 
```

我们可以进一步简化，直接添加时间
```
     let delay = DispatchTime.now() + 10
     DispatchQueue.main.asyncAfter(deadline: delay) {
         // 延迟执行
     }
```
因为在DispatchTime中自定义了“+”号。

public func +(time: DispatchTime, seconds: Double) -> DispatchTime

更多有关延时操作看这里


DispatchGroup

DispatchGroup用于管理一组任务的执行，然后监听任务的完成，进而执行后续操作。比如：同一个页面发送多个网络请求，等待所有结果请求成功刷新UI界面。一般的操作如下：

    let queue = DispatchQueue.global()
    let group = DispatchGroup()
     
    queue.async(group: group) {
        print("Task one finished")
    }
    queue.async(group: group) {
        print("Task two finished")
    }
    queue.async(group: group) {
        print("Task three finished")
    }
    group.notify(queue: queue) {
        print("All task has finished")
    }

打印如下：
```

Task three finished

Task two finished

Task one finished

All task has finished
```
由于是并发执行异步任务，所以任务的先后次序是不一定的，看起来符合我们的需求，最后接受通知然后可以刷新UI操作。但是真实的网络请求是异步、耗时的，并不是立马就返回，所以我们使用asyncAfter模拟延时看看，将任务1延时一秒执行：
```
     let queue = DispatchQueue.global()
     let group = DispatchGroup()
     
     queue.async(group: group) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
             print("Task one finished")
         })
     }
     queue.async(group: group) {
         print("Task two finished")
     }
     queue.async(group: group) {
         print("Task three finished")
     }
     group.notify(queue: queue) {
         print("All task has finished")
     }
```
结果却不是我们预期的那样，输出结果如下：
```
Task two finished

Task three finished

All task has finished 

Task one finished
```
所以，为了真正实现预期的效果，我们需要配合group的enter和leave两个函数。每次执行group.enter()表示一个任务被加入到列队组group中，此时group中的任务的引用计数会加1，当使用group.leave() ，表示group中的一个任务完成，group中任务的引用计数减1.当group列队组里面的任务引用计数为0时，会通知notify函数，任务执行完成。注意：enter()和leave()成对出现的。
```
      let queue = DispatchQueue.global()
      let group = DispatchGroup()
     
      group.enter()
      queue.async(group: group) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
               print("Task one finished")
               group.leave()
          })
       }
     
       group.enter()
       queue.async(group: group) {
           print("Task two finished")
           group.leave()
       }
     
       group.enter()
       queue.async(group: group) {
           print("Task three finished")
           group.leave()
       }
     
       group.notify(queue: queue) {
           print("All task has finished")
       }
```
这下OK了，输出跟预期一样。当然这里也可以使用信号量实现，后面会介绍。

Task three finished

Task two finished

Task one finished

All task has finished
信号量

对于信号量的具体内容，可以看我之前写的一篇博文。使用起来很简单，创建信号量对象，调用signal方法发送信号，信号加1，调用wait方法等待，信号减1.现在也适用信号量实现刚刚的多个请求功能。
```
       let queue = DispatchQueue.global()
       let group = DispatchGroup()
       let semaphore = DispatchSemaphore(value: 0)
     
       queue.async(group: group) {
           DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
               semaphore.signal()
               print("Task one finished")
           })
           semaphore.wait()
       }
       queue.async(group: group) {
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
               semaphore.signal()
               print("Task two finished")
           })
           semaphore.wait()
       }
       queue.async(group: group) {
           print("Task three finished")
       }
     
       group.notify(queue: queue) {
           print("All task has finished")
       }
```
Suspend / Resume

Suspend可以挂起一个线程，即暂停线程，但是仍然暂用资源，只是不执行

Resume回复线程，即继续执行挂起的线程。


循环执行任务

之前使用GCD的dispatch_apply()执行多次任务，现在是调用concurrentPerform(),下面是并发执行5次
```
    DispatchQueue.concurrentPerform(iterations: 5) {
         print("\($0)")
     }
```
DispatchSource

DispatchSource提高了相关的API来监控低级别的系统对象，比如：Mach ports, Unix descriptors, Unix signals, VFS nodes。并且能够异步提交事件到派发列队执行。

简单定时器
```
    // 定时时间
    var timeCount = 60
    // 创建时间源
    let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    timer.schedule(deadline: .now(), repeating: .seconds(1))
    timer.setEventHandler {
        timeCount -= 1
        if timeCount <= 0 { timer.cancel() }
        DispatchQueue.main.async {
            // update UI or other task
        }
    }
    // 启动时间源
    timer.resume()
```
对于比使用Timer的好处可以看这里


应用场景  
多个任务依次执行  

最容易想到的就是创建一个串行列队，然后添加任务到列队执行。   
```
    let serialQueue = DispatchQueue(label: "com.my.queue")
    serialQueue.async {
       print("task one")
    }
    serialQueue.async {
       print("task two")
    }
    serialQueue.async {
       print("task three")
    }
```
其次就是使用前面讲到的DispatchGroup。
取消DispatchWorkItem的任务
直接取消任务
```
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    let workItem = DispatchWorkItem {
        print("done")
    }
     
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        queue.async(execute: workItem) // not work
    }
    workItem.cancel()
```
直接调用取消，异步任务不会执行。   
执行的过程中取消任务  
```
    func cancelWork() {
         let queue = DispatchQueue.global()
         var item: DispatchWorkItem!
     
         // create work item
         item = DispatchWorkItem { [weak self] in
              for i in 0 ... 10_000_000 {
                  if item.isCancelled { break }
                  print(i)
                  self?.heavyWork()
              }
              item = nil    // resolve strong reference cycle
         }
     
         // start it
         queue.async(execute: item)
     
         // after five seconds, stop it if it hasn't already
         queue.asyncAfter(deadline: .now() + 5) { [weak item] in
                item?.cancel()
         }
    }
```
具体详情看这里，也可以了解这篇文章  

注意事项  
线程死锁  

不要在主列队中执行同步任务，这样会造成死锁问题。  













### NSTheard

<h3>多线程</h3>
<p>NSThread</p>
1、创建NSThread的两种方式
<br>
-(id) initWithTarget:(id) target selector:(SEL) selector object:(id) arg:
<br>
+(void)detachNewThreadSelector:(SEL) selector toTarget:(id) target withObject:(id) arg:
<br>
第二种方式，创建NSThread后会自动启动
<br>


2、NSThread的常用方法
<br>
+currentThread ： 返回当前正在执行的线程对象
<br>

<p>GCD</p>
GCD简化了多线程的实现，主要有两个核心概念：
<br>
1、队列：队列负责管理开发者提交的任务，以先进先出的方式来处理任务。
<br>
1）串行队列：每次只执行一个任务，当前一个任务执行完成后才执行下一个任务
<br>
2）并行队列：多个任务并发执行，所以先执行的任务可能最后才完成（因为具体的执行过程导致）
<br>
2、任务：任务就是开发者提供给队列的工作单元，这些任务将会提交给队列底层维护的线程池，因此这些任务将会以多线程的方式执行。
<p>NSOperation</p>
NSOperationQueue：代表一个先进先出的队列，负责管理系统提交的多个NSOperation。底层维护一个线程池，会按顺序启动线程来执行提交给队列的NSOperation
<br>
NSOperation：代表多线程任务。一般不直接使用NSOperation，而是使用NSOperation的子类。或者使用NSInvocationOperation和NSBlockOperation（这两个类继承自NSOperation）；
<br>
1、NSOperation的使用
<br>
NSOperation 的使用相较于GCD是面向对象的，OC实现的，而GCD应该是C实现的（看函数的定义和使用）。
<br>
使用NSOperation 只需两步：
<br>
1）创建 NSOperationQueue 队列，并未该队列设置相关属性
<br>
2）创建 NSOperation 子类对象，并将该对象提交给 NSOperationQueue 队列，该队列将会按顺序依次启动每个 NSOperation。
<br>



### 参考:
[在iOS中有几种方法来解决多线程访问同一个内存地址的互斥同步问题](https://blog.csdn.net/a_ellisa/article/details/51506233)    
[iOS － 关于dispatch_sync(dispatch_get_main_queue(), ^{...;}); 死锁问题的解释](https://blog.csdn.net/icefishlily/article/details/52596802)    
[GCD:嵌套dispatch_async时__block对象的一个内存陷阱](https://blog.csdn.net/fg313071405/article/details/25962939)    
[ios-多线程访问共享资源](https://blog.csdn.net/ZCMUCZX/article/details/76974068)    
[iOS开发多线程篇—线程安全](https://www.cnblogs.com/wendingding/p/3805841.html)    
[iOS开发笔记之五十七——__weak与__strong是如何解决循环引用的](https://blog.csdn.net/lizitao/article/details/54845974)    
[GCD实践（一）使用GCD保护property ](https://zhangbuhuai.com/gcd-part-1/)  
[iOS - 多线程你看全不全](https://juejin.im/entry/57dcc1cc0bd1d00057e97dc7)  


[Swift4 - GCD的使用](https://blog.csdn.net/longshihua/article/details/79756676)   
[Swift4.0 - GCD](https://www.jianshu.com/p/96032a032c7c)  


[多线程之GCD](https://blog.csdn.net/longshihua/article/details/50523051)  