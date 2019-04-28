### 多线程的定时器和延时操作

Swift 4.0中对 GCD定时器的写法做了很多改进，使之更符合Swift的语言特点，比OC的语法看起来是简明清晰了不少
```
/// GCD定时器倒计时⏳
///   - timeInterval: 循环间隔时间
///   - repeatCount: 重复次数
///   - handler: 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
public func DispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->())
{
    if repeatCount <= 0 {
        return
    }
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var count = repeatCount
    timer.schedule(wallDeadline: .now(), repeating: timeInterval)
    timer.setEventHandler(handler: {
        count -= 1
        DispatchQueue.main.async {
            handler(timer, count)
        }
        if count == 0 {
            timer.cancel()
        }
    }) 
    timer.resume()
}
```

```
/// GCD定时器循环操作
///   - timeInterval: 循环间隔时间
///   - handler: 循环事件
public func DispatchTimer(timeInterval: Double, handler:@escaping (DispatchSourceTimer?)->())
{
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    timer.schedule(deadline: .now(), repeating: timeInterval)
    timer.setEventHandler {
        DispatchQueue.main.async {
            handler(timer)
        }
    }
    timer.resume()
}
```
```
/// GCD延时操作
///   - after: 延迟的时间
///   - handler: 事件
public func DispatchAfter(after: Double, handler:@escaping ()->())
{
    DispatchQueue.main.asyncAfter(deadline: .now() + after) { 
        handler()
    }
}
```

函数的使用
```
override func viewDidLoad() {
    super.viewDidLoad()


    DispatchTimer(timeInterval: 1, repeatCount: 10) { (timer, count) in
        print("剩余执行次数 = \(count)")
    }

    DispatchAfter(after: 5) { 
        print("您好")
    }
}
```

```
打印结果： 
剩余执行次数 = 9 
剩余执行次数 = 8 
剩余执行次数 = 7 
剩余执行次数 = 6 
剩余执行次数 = 5 
您好 
剩余执行次数 = 4 
剩余执行次数 = 3 
剩余执行次数 = 2 
剩余执行次数 = 1 
剩余执行次数 = 0
```

#### 参考
[Swift 4.0中 GCD定时器写法，及延时操作](https://blog.csdn.net/zxw_xzr/article/details/78317936#)  
