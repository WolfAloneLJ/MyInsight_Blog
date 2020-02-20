## Ubuntu下gedit乱码


### ubuntu下gedit默认编码设置
 
ubuntu 下gedit默认编码为UTF-8（这个在麒麟14.04中好像不是，因此用下面的方法），而在windows下编写得txt默认编码位GBK，所以在windowx下面的txt用getdit打开则为乱码，解决方案：  
 
在终端下输入：  
`gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8', 'GB18030', 'GB2312', 'GBK', 'BIG5', 'CURRENT', 'UTF-16']"`
 
  然后继续输入：  
`gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['UTF-8', 'GB18030', 'GB2312', 'GBK', 'BIG5', 'CURRENT', 'UTF-16']"`

经过上面两个步骤，gedit工作正常了


也可以安装配置工具  
 
  这是在终端下设置的，同图形化界面，则安装 `dconf-editor`
 ```
  sudo apt-get install dconf-tools
  ```
  终端中输入命令：`$ dconf-editor`
 
  依次点开`->org->gnome->gedit->preferences->encodings`
 
  但是我改变里面得参数值，最终还是没有效果，原因不明，但是这里可以看到默认编码是什么。 


### 参考
[解决Ubuntu 下Gedit中文乱码问题](https://blog.csdn.net/lemonzone2010/article/details/6041187)  
[ubuntu下gedit默认编码设置为UTF-8编码](https://blog.csdn.net/miscclp/article/details/39154639)  



