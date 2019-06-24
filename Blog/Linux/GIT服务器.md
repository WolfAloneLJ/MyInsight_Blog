## Ubuntu搭建git服务器

### 1.安装Git
```
$sudo apt update
$sudo apt upgrade
$sudo apt install git
```
### 2.创建证书登录
收集需要登录的用户的公钥(在客户机)，公钥一般位于 ~/.ssh 或者 C:\Users\sumlo\.ssh 中的 id_rsa.pub 文件中，将内容写入服务器的 /home/git/.ssh/authorized_keys 文件中（若没有则创建）  
```
$cd /home/sml  # 账户
$mkdir .ssh
$chmod 700 .ssh
$touch .ssh/authorized_keys
$chmod 600 .ssh/authorized_keys
```

重要的来了！设置很多免密的问题都在这
```
$cd home
$chown -R sml:sml git #设置git文件夹归sml用户所有   
```
同时，修改公钥存放文件
```
$vi /etc/ssh/sshd_config
```
修改
```
AuthorizedKeysFile home/git/.ssh/authorized_keys  
```

### 3.禁止Shell登录
服务器端处于安全考虑，git用户不允许登录shell，否则通过ssh可以直接登录服务器  
编辑 `/etc/passwd` 修改：
```
git:x:1001:1001:,,,:/home/git:/bin/bash     
```
修改为
```
git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell 
```
这样git可以正常通过ssh使用git但是无法登录服务器




### 参考
[Ubuntu16搭建私人git服务器](https://blog.csdn.net/u011050582/article/details/78768408)  
[ubuntu完美搭建git服务器](https://blog.csdn.net/Liuqz2009/article/details/78396625)  


[rebase 用法小结](https://www.jianshu.com/p/4a8f4af4e803)

