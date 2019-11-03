## Flask

使用框架的优点：
稳定性和可扩张性强
可以降低开发难度，提高开发效率

### 安装环境
使用虚拟环境安装Flask，可以避免包的混乱和版本的冲突，虚拟环境是Python解释器的副本，  
在虚拟环境中你可以安装扩展包。为每个程序单独创建的虚拟环境，可以保证程序只能访问虚拟环境中的包。
而不会影响系统中安装的全局Python解释器，从而保证全局解释器的整洁。

虚拟环境使用`virtualenv`创建，可以查看是否安装了`virtualenv`
```shell script
$ virtualenv --version
```

安装虚拟环境
```shell script
$ sudo pip install virtualenv
$ sudo pip install virtualenvwrapper
```

创建虚拟环境
```shell script
$ mkvirtualenv Flask_py # Flask_py虚拟环境
```

安装完虚拟环境后，如果提示找不到`mkvirtualenv`命令，须配置环境变量:
```shell script
# 1.创建目录用来存放虚拟环境
mkdir $HOME/.virtualenvs

# 2.打开~/.bashrc文件，并添加如下:
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# 3.运行
source ~/.bashrc
```

进入虚拟环境
```shell script
$ workon Flask_py
```
退出虚拟环境
```shell script
$ deactivate Flask_py
```

安装Flask
```shell script
# 指定Flask版本安装
$ pip install flask==0.10.1
pip freeze > requirements.txt

# Mac系统
$ esay_install flask=0.10.1

# 在ipython中测试安装是否成功
$ from flask import Flask
```

requirements文件
Python项目中必须包含一个requirements.txt文件，用于记录所有依赖包及其精确的版本号，
以便在新环境中进行部署操作。
在虚拟环境使用以下命令将当前虚拟环境中的依赖包以及版本号生成至文件中:
```shell script
$ pip freeze > requirements.txt
```
安装或升级包后，最好更新这个文件以保证虚拟环境中的依赖包

当需要创建这个虚拟环境的完全副本，可以创建一个新的虚拟环境，并在其上运行以下命令:
```shell script
$ pip install -r requirements.txt
```


### 扩展


### 基础


### 模板


### Web表单
在Flask中，为了处理web表单，我们一般用Flask-WTF扩展，它封装了WTFroms，并且它有验证表单数据的功能。





### Flask中使用数据库
#### Flask-SQLAlchemy扩展
* SQLALchemy实际上是对数据库的抽象，让开发者不用直接和SQL语句打交道，而是通过Python对象来操作数据库，
在舍弃一些性能开销的同时，换来的是开发效率的较大提升。
* SQLALchemy是一个关系型数据库框架，它提供了高层的ORM和底层的原生数据库的操作。
sqlalchemy是一个简化了SQLALchemy操作的flask扩展

#### 安装flask-sqlalchemy
`pip install flask-sqlalchemy`

如果连接的是mysql数据库，需要安装`mysqldb`
 `pip install flask-mysqldb`

#### 使用Flask-SQLAlchemy管理数据库
在Flask-SQLAlchemy中，数据库使用URL指定，而且程序使用的数据库必须保存到Flask配置对象的SQLALCHEMY_DATABASE_URI键中

##### Flask的数据库设置:
`app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:mysql@127.0.0.1:3306/test'`

其他设置
```shell script
# 动态追踪修改设置，如未设置只会提示警告，不建议开启
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# 查询时会显示原始SQL语句
app.config['SQLALCHEMY_ECHO'] = True
```



#### 参考



