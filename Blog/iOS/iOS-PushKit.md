##  iOS PushKit


### 创建证书



### 生成证书



### 处理证书
到此为止，我们已经有了两个.p12文件，把他们放到同一个文件夹(aaa)下，需要把两个.p12文件转换成.pem文件。

a.先打开终端，切换到文件夹aaa下执行
`openssl pkcs12 -clcerts -nokeys -out cert.pem -in cert.p12`

在执行的时候，将会让输入密码，输入刚才设置的密码即可生成一个cert.pem文件。

b.再执行：
`openssl pkcs12 -nocerts -out key.pem -in key.p12`

此时要注意在终端中的提示，第一次输入的密码是生成证书时候的密码，第二次第三次输入密码是设置key.pem的新密码。

c.如果需要对 key不进行加密，执行下边语句
`openssl rsa -in key.pem -out key.unencrypted.pem`

d.然后就可以合并两个.pem文件,这个ck.pem就是服务端需要的证书了。
`cat cert.pem key.unencrypted.pem > ck.pem`

将第8步得到的pem文件转换为p12文件
`openssl pkcs12 -export -in ck.pem -out pushcer.p12`

此时，把生成的ck.pem和pushcer.p12给服务器端的人员即可。

测试证书是否有效
`telnet gateway.sandbox.push.apple.com 2195`
它将尝试发送一个规则的，不加密的连接到APNS服务。如果你看到上面的反馈，那说明你的MAC能够到达APNS。按下Ctrl+C关闭连接。如果得到一个错误信息，那么你需要确保你的防火墙允许2195端口。一般这里都不会出现什么问题。

下面我们要使用我们生成的SSL证书和私钥来设置一个安全的链接去链接苹果服务器：
`openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert PushCert.pem -key PushKey.pem`
执行完这一句后会提示输入private_key.pem的密码 
Enter pass phrase for private_key.pem:

你会看到一个完整的输出，让你明白OpenSSL在后台做什么。如果链接是成功的，你可以随便输入一个字符，按下回车，服务器就会断开链接，如果建立连接时有问题，OpenSSL会给你返回一个错误信息。 
当你在最后的时候你看到这样说明你已经成功了


### 参考
[iOS利用voip push实现类似微信(QQ)电话连续响铃效果](https://oopsr.github.io/2016/06/20/voip/)
[PushKit_SilentPushNotification](https://github.com/hasyapanchasara/PushKit_SilentPushNotification)
[使用APNS 搭建苹果推送服务器错误：unable to connect to ssl://gateway.sandbox.push.apple.com:2195 错误](https://www.cnblogs.com/cocoajin/p/3470673.html)
[How to build an Apple Push Notification provider server (tutorial)](https://blog.serverdensity.com/how-to-build-an-apple-push-notification-provider-server-tutorial/)

[iOS 8 pushkit使用总结](https://www.jianshu.com/p/5939dcb5fcd2)
[iOS原生APNS推送之PHP后台的pem证书制作流程](https://www.jianshu.com/p/d97074434f11)

[iOS VoIP PushKit 的问题](https://www.cnblogs.com/windsSunShine/p/9399515.html)

[检测苹果推送证书有效性](https://blog.csdn.net/nogodoss/article/details/42142205)
[IOS Push 证书的重新生成](https://blog.csdn.net/think12/article/details/8863411)

[IOS消息推送(VOIP)](https://blog.csdn.net/heyufei/article/details/53616961)
