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



### 数据库



 

#### 参考



