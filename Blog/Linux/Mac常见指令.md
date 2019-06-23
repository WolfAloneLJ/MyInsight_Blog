##  一些指令


### [HomeBrew](https://brew.sh)
安装
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
卸载
```
cd `brew --prefix`
rm -rf Cellar
brew prune
rm `git ls-files`
rm -r Library/Homebrew Library/Aliases Library/Formula Library/Contributions
rm -rf .git
rm -rf ~/Library/Caches/Homebrew
```

使用
1. 安装任意包
```
brew install <packageName>
```
卸载任意包
```
brew uninstall <packageName>
```
查询可用包
```
brew search <packageName>
```
查看已安装包列表
```
brew list
```
查看任意包信息
```
brew info <packageName>
```
更新HomeBrew
```
brew update
```
查看Homebrew版本
```
brew -v
```
Homebrew帮助信息
```
brew -h
```

### nmp包管理








Xcode工程清除缓存路径
```
~/Library/Developer/Xcode/DerivedData/
```



### Mac完全卸载AndroidStudio
步骤1:
```
rm -Rf /Applications/Android\ Studio.app
rm -Rf ~/Library/Preferences/AndroidStudio*
rm ~/Library/Preferences/com.google.android.studio.plist
rm -Rf ~/Library/Application\ Support/AndroidStudio*
rm -Rf ~/Library/Logs/AndroidStudio*
rm -Rf ~/Library/Caches/AndroidStudio*
```

步骤2:
```
rm -Rf ~/AndroidStudioProjects
```
步骤3:
```
rm -Rf ~/.gradle
```

步骤4:
```
rm -Rf ~/.android
```

步骤5:
```
rm -Rf ~/Library/Android*
```

### 参考:
[Homebrew介绍和使用](https://www.jianshu.com/p/de6f1d2d37bf)

[MAC 下查看.a 以及 .framework 支持的架构](https://blog.csdn.net/u012224226/article/details/50848311)




