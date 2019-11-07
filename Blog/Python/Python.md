## Python 

能使用Python交互模式的时候，建议使用iPython进行交互

### Windows修改pip源
pip国内的一些镜像:  
1. [阿里云](http://mirrors.aliyun.com/pypi/simple/)`http://mirrors.aliyun.com/pypi/simple/`
2. [中国科技大学](https://pypi.mirrors.ustc.edu.cn/simple/)`https://pypi.mirrors.ustc.edu.cn/simple/`  
3. [豆瓣(douban)](http://pypi.douban.com/simple/)`http://pypi.douban.com/simple/`
4. [清华大学](https://pypi.tuna.tsinghua.edu.cn/simple/)`https://pypi.tuna.tsinghua.edu.cn/simple/` 
5. [中国科学技术大学](http://pypi.mirrors.ustc.edu.cn/simple/)`http://pypi.mirrors.ustc.edu.cn/simple/`

修改pip源步骤:
1. 在文件夹的地址栏输入 %appdata% （即进入这个文件夹）。
2. 在当前文件夹下新建一个pip文件夹。
3. 进入pip文件夹，新建一个pip.ini文件
4. 在pip.ini文件中写下如下内容:
    ```shell script
    [global]
    timeout = 6000
    index-url = http://pypi.douban.com/simple
    trusted-host = pypi.douban.com
    ```
5. 保存退出，即配置完成。在打开cmd使用pip就使用了新的pip源。

### 参考:
[windows修改pip源](https://blog.csdn.net/hopyGreat/article/details/79668275)  
[更换（Pypi）pip源到国内镜像](https://yq.aliyun.com/articles/652884)  
[Windows下修改pip源](https://blog.csdn.net/qq_26972303/article/details/53439224)  

[Python continue 语句](https://www.runoob.com/python/python-continue-statement.html)  

[创建指定python版本的虚拟环境](https://www.cnblogs.com/pythoner6833/default.html?page=5)  

