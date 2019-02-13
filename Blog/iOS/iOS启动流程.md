#### My-iOS启动流程

iOS程序启动->dyld加载->runtime初始化 过程






#### 程序的五种状态
Not Running：未运行。  
Inactive：前台非活动状态。处于前台，但是不能接受事件处理。  
Active：前台活动状态。处于前台，能接受事件处理。  
Background：后台状态。进入后台，如果又可执行代码，会执行代码，代码执行完毕，程序进行挂起。  
Suspended：挂起状态。进入后台，不能执行代码，如果内存不足，程序会被杀死。  



AppDelegate中的回调方法和通知  
（1）回调方法：application:didFinishLaunchingWithOptions:  
          本地通知：UIApplicationDidFinishLaunchingNotification  
          触发时机：程序启动并进行初始化的时候后。  
          适宜操作：这个阶段应该进行根视图的创建。  
（2）回调方法：applicationDidBecomeActive：  
          本地通知：UIApplicationDidBecomeActiveNotification  
          触发时机：程序进入前台并处于活动状态时调用。  
          适宜操作：这个阶段应该恢复UI状态（例如游戏状态）。  
（3）回调方法：applicationWillResignActive:  
          本地通知：UIApplicationWillResignActiveNotification  
          触发时机：从活动状态进入非活动状态。
          适宜操作：这个阶段应该保存UI状态（例如游戏状态）。
 （4）回调方法：applicationDidEnterBackground:  
          本地通知：UIApplicationDidEnterBackgroundNotification
          触发时机：程序进入后台时调用。  
          适宜操作：这个阶段应该保存用户数据，释放一些资源（例如释放数据库资源）。
（5）回调方法：applicationWillEnterForeground：  
          本地通知：UIApplicationWillEnterForegroundNotification
          触发时机：程序进入前台，但是还没有处于活动状态时调用。
          适宜操作：这个阶段应该恢复用户数据。  
（6）回调方法：applicationWillTerminate:  
          本地通知：UIApplicationWillTerminateNotification
          触发时机：程序被杀死时调用。  
          适宜操作：这个阶段应该进行释放一些资源和保存用户数据。
 
 4、程序启动  
点击应用图标时，会经历三个状态：  
Not running-->Inactive-->Active   
  
Not running --> Inactive  
调用 application:didFinishLaunchingWithOptions: 发送：UIApplicationDidFinishLaunchingNotification 
Inactive-->Active    

调用 applicationDidBecomeActive： 发送：UIApplicationDidBecomeActiveNotification     

 5、程序Home
根据info.plist中Application does not run in background  /   UIApplicationExitsOnSuspend控制似乎否可以在后台运行或挂起。    
如果可以在后台运行或者挂起会经历  
Active-->Inactive-->Background-->Suspended   

Active-->Inactive 
调用 applicationWillResignActive： 发送：UIApplicationWillResignActiveNotification   
Background-->Suspended   
调用 applicationDidEnterBackground： 发送：UIApplicationDidEnterBackgroundNotification   

如果不可以后台运行或挂起会经历
 Active-->Inactive-->Background-->Suspended-->Not Running

Background-->Suspended 
调用 applicationDidEnterBackground： 发送：UIApplicationDidEnterBackgroundNotification    
Suspended-->Not Running 
调用 applicationWillTerminate： 发送：UIApplicationWillTerminateNotification

6、挂起后，重新运行
Suspended-->Background-->Inactive-->Active  

 Background-->Inactive   
 调用 applicationWillEnterForeground： 发送：UIApplicationWillEnterForegroundNotification   
 Inactive-->Active    
调用 applicationDidBecomeActive： 发送：UIApplicationDidBecomeActiveNotification     
  
 7、内存不足，杀死程序    
 Background-->Suspended-->Not running  
这种情况不会调用任何方法，也不会发送任何通知。  

 