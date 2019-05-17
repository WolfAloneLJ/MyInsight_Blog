Socket描述了一个IP、端口对。它简化了程序员的操作，知道对方的IP以及PORT就可以给对方发送消息，再由服务器端来处理发送的这些消息。所以，Socket一定包含了通信的双发，即客户端（Client）与服务端（server）。   
1）服务端利用Socket监听端口；   
2）客户端发起连接；   
3）服务端返回信息，建立连接，开始通信；   
4）客户端，服务端断开连接。   

1套接字（socket）概念 套接字（socket）是通信的基石，是支持TCP/IP协议的网络通信的基本操作单元。 应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。为了**区别不同的应用程序进程和连接**，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应 用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。   
2 建立socket连接 建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket，另一个运行于服务器端，称为ServerSocket。 套接字之间的连接过程分为三个步骤：  
服务器监听，客户端请求，连接确认。   
服务器监听：服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态，等待客户端的连接请求。   
客户端请求：指客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。为此，客户端的套接字必须首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。   
连接确认：当服务器端套接字监听到或者说接收到客户端套接字的连接请求时，就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发 给客户端，一旦客户端确认了此描述，双方就正式建立连接。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。   
4、SOCKET连接与TCP连接 创建Socket连接时，可以指定使用的传输层协议，Socket可以支持不同的传输层协议（TCP或UDP），当使用TCP协议进行连接时，该Socket连接就是一个TCP连接。 5、Socket连接与HTTP连接 由于通常情况下Socket连接就是TCP连接，因此Socket连接一旦建立，通信双方即可开始相互发送数据内容，直到双方连接断开。但在实际网 络应用中，客户端到服务器之间的通信往往需要穿越多个中间节点，例如路由器、网关、防火墙等，大部分防火墙默认会关闭长时间处于非活跃状态的连接而导致 Socket 连接断连，因此需要通过轮询告诉网络，该连接处于活跃状态。 而HTTP连接使用的是“请求—响应”的方式，不仅在请求时需要先建立连接，而且需要客户端向服务器发出请求后，服务器端才能回复数据。 很多情况下，需要服务器端主动向客户端推送 iphone的标准推荐CFNetwork C库编程.但是编程比较烦躁。在其它OS往往用类来封装的对Socket函数的处理。比如MFC的CAsysncSocket.在iphone也有类似于 开源项目.cocoa AsyncSocket库, 官方网站:http://code.google.com/p/cocoaasyncsocket/ 它用来简化 CFnetwork的调用.   
一.在项目引入ASyncSocket库   
1.下载ASyncSocket库源码   
2.把ASyncSocket库源码加入项目：  
只需要增加RunLoop目录中的AsyncSocket.h、AsyncSocket.m、AsyncUdpSocket.h和AsyncUdpSocket.m四个文件。  
3.在项目增加CFNetwork框架 在Framework目录右健,选择Add-->Existing Files... , 选择 CFNetwork.framework   

二.TCP客户端   
1. 在controller头文件定义AsyncSocket对象 
```aidl
import "AsyncSocket.h" 
@interface HelloiPhoneViewController : UIViewController { 
UITextField * textField; AsyncSocket * asyncSocket; 
} 
@property (retain, nonatomic) IBOutlet UITextField *textField; 
(IBAction) buttonPressed: (id)sender; 
(IBAction) textFieldDoneEditing: (id)sender; @end  
```


2.在需要联接地方使用connectToHost联接服务器 其中initWithDelegate的参数中self是必须。这个对象指针中的各个Socket响应的函数将被ASyncSocket所调用. 
asyncSocket = [[AsyncSocket alloc] initWithDelegate:self]; 
NSError *err = nil;
 if(![asyncSocket connectToHost:host on:port error:&err]) { 
 NSLog(@"Error: %@", err); 
 } 
 
3.增加Socket响应事件 因为initWithDelegate把将当前对象传递进去，这样只要在当前对象方法实现相应方法.   
4.关于NSData对象 无论SOCKET收发都采用NSData对象.
它的定义是 http://developer.apple.com/library/mac /#documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html 
NSData主要是带一个(id)data指向的数据空间和长度 length. NSString 转换成NSData 对象 NSData* xmlData = [@"testdata" dataUsingEncoding:NSUTF8StringEncoding]; 
NSData 转换成NSString对象 NSData * data; 
NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];   

4.发送数据 AsyncSocket writeData 方法来发送数据，
它有如下定义 
- (void)writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag; 
以下是一个实例语句. 
NSData* aData= [@"test data" dataUsingEncoding: NSUTF8StringEncoding]; 
[sock writeData:aData withTimeout:-1 tag:1]; 
在onSocket重载函数，有如定义采用是专门用来处理SOCKET的发送数据的： 
-(void)onSocket(AsyncSocket *)sock didWriteDataWithTag:(long)tag { 
NSLog(@"thread(%),onSocket:%p didWriteDataWithTag:%d",[[NSThread currentThread] name], sock,tag); 
}   

5.接收Socket数据. 在onSocket重载函数，有如定义采用是专门用来处理SOCKET的接收数据的. 
-(void) onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag 
在中间将其转换成NSString进行显示. 
NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; 
NSLog(@"===%@",aStr); [aStr release]; 

Asyncsocket的例子： 下面是用开源的库Asyncsocket的例子：

```
//
//  SocketDemoViewController.h
//  SocketDemo
//
//  Created by xiang xiva on 10-7-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#define SRV_CONNECTED 0
#define SRV_CONNECT_SUC 1
#define SRV_CONNECT_FAIL 2
#define HOST_IP @"192.168.110.1"
#define HOST_PORT 8080

@interface SocketDemoViewController : UIViewController {

 UITextField *inputMsg;
 UILabel *outputMsg;
 AsyncSocket *client;
}

@property (nonatomic, retain) AsyncSocket *client;
@property (nonatomic, retain) IBOutlet UITextField *inputMsg;
@property (nonatomic, retain) IBOutlet UILabel *outputMsg;

- (int) connectServer: (NSString *) hostIP port:(int) hostPort;
- (void) showMessage:(NSString *) msg;
- (IBAction) sendMsg;
- (IBAction) reConnect;
- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) backgroundTouch:(id)sender;

@end



//
//  SocketDemoViewController.m
//  SocketDemo
//
//  Created by xiang xiva on 10-7-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SocketDemoViewController.h"

@implementation SocketDemoViewController

@synthesize inputMsg, outputMsg;
@synthesize client;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    //[super viewDidLoad];
 [self connectServer:HOST_IP port:HOST_PORT];
 //监听读取

}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
 // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

 // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
 self.client = nil;
 // Release any retained subviews of the main view.
 // e.g. self.myOutlet = nil;
}

- (int) connectServer: (NSString *) hostIP port:(int) hostPort{

 if (client == nil) {
  client = [[AsyncSocket alloc] initWithDelegate:self];
  NSError *err = nil;
  //192.168.110.128
  if (![client connectToHost:hostIP onPort:hostPort error:&err]) {
   NSLog(@"%@ %@", [err code], [err localizedDescription]);

   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[@"Connection failed to host "
           stringByAppendingString:hostIP]
               message:[[[NSString alloc]initWithFormat:@"%@",[err code]] stringByAppendingString:[err localizedDescription]]
                 delegate:self
              cancelButtonTitle:@"OK"
              otherButtonTitles:nil];
   [alert show];
   [alert release];
   //client = nil;
   return SRV_CONNECT_FAIL;
  } else {
   NSLog(@"Conectou!");
   return SRV_CONNECT_SUC;
  }
 }
 else {
  [client readDataWithTimeout:-1 tag:0];
  return SRV_CONNECTED;
 }

}

- (IBAction) reConnect{
 int stat = [self connectServer:HOST_IP port:HOST_PORT];
 switch (stat) {
  case SRV_CONNECT_SUC:
   [self showMessage:@"connect success"];
   break;
  case SRV_CONNECTED:
   [self showMessage:@"It's connected,don't agian"];
   break;
  default:
   break;
 }
}

- (IBAction) sendMsg{

 NSString *inputMsgStr = self.inputMsg.text;
 NSString * content = [inputMsgStr stringByAppendingString:@"rn"];
 NSLog(@"%a",content);
 NSData *data = [content dataUsingEncoding:NSISOLatin1StringEncoding];
 [client writeData:data withTimeout:-1 tag:0];

 //[data release];
 //[content release];
 //[inputMsgStr release];
 //继续监听读取
 //[client readDataWithTimeout:-1 tag:0];
}

#pragma mark -
#pragma mark close Keyboard
- (IBAction) textFieldDoneEditing:(id)sender{
 [sender resignFirstResponder];
}

- (IBAction) backgroundTouch:(id)sender{
 [inputMsg resignFirstResponder];
}

#pragma mark socket uitl

- (void) showMessage:(NSString *) msg{
 UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert!"
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


#pragma mark socket delegate

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
 [client readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"Error");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
 NSString *msg = @"Sorry this connect is failure";
 [self showMessage:msg];
 [msg release];
 client = nil;
}

- (void)onSocketDidSecure:(AsyncSocket *)sock{

}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{

 NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"Hava received datas is :%@",aStr);
 self.outputMsg.text = aStr;
 [aStr release];
 [client readDataWithTimeout:-1 tag:0];
}

#pragma mark dealloc

- (void)dealloc {

 [client release];
 [inputMsg release];
 [outputMsg release];
    [super dealloc];
}

@end
```

///////
sq是socket的线程，这个是可选的设置，如果你写null，GCDAsyncSocket内部会帮你创建一个它自己的socket线程，如果你要自己提供一个socket线程的话，千万不要提供一个并发线程，在频繁socket通信过程中，可能会阻塞掉，个人建议是不用创建





### 参考
[iOS socket编程 第三方库 AsyncSocket(GCDAsyncSocket)](https://www.cnblogs.com/wanyakun/p/3403348.html)  
[GCDAsyncSocket 简单使用](https://www.jianshu.com/p/65889f4f0bb1)  
[iOS-Socket-UDP/TCP:客户端点对点和客户端对服务器数据收发](https://www.jianshu.com/p/2e408c3eaaa8)  
[GCDAsyncUdpSocket局域网广播发送与接收，客户端与服务端实现](https://blog.csdn.net/lyh20133102/article/details/85696047)  
