## Mac清理硬盘

#### 1.Xcode产生垃圾
` /Users/exchen/Library/Developer/Xcode/DerivedData`
Xcode 编译产生的临时文件，可以全部清空掉。这个一般会占用几个 G

` /Users/exchen/Library/Developer/Xcode/iOS DeviceSupport` Xcode 用于调试产生成系统符号文件，根据情况可以删除一些不常用调试的机型，一般会占用几十个G


` /Users/exchen/Library/Developer/Xcode/Archives` Xcode 的打包文件都保存在这里，一般会有 几个 G

#### 2.iTunes 的备份目录
手机插入电脑之后，默认 iTunes 会自动备份，可以根据情况删除不需要备份的目录，打开 
`/Users/exchen/Library/Application Support/MobileSync/Backup`，
会看到相应的备份目录，一个目录就是一台手机的备份数据。信息如下：
```
$ du -h
6.9M	./68595a50880ac28f66a337e338b6b433e45232d8/Snapshot
835M	./68595a50880ac28f66a337e338b6b433e45232d8
835M	.
$ rm -rf 68595a50880ac28f66a337e338b6b433e45232d8
```

使用 iTunes 安装的应用会保存 IPA 包，
目录是：`/Users/exchen/Music/iTunes/iTunes Media`，
没必要保存的 IPA 可以进行删除。


### 参考:
[macOS 手动清理垃圾文件](https://blog.csdn.net/SysProgram/article/details/89287219)  
[MacOS 系统占用100+G清理优化](https://blog.csdn.net/jiaotuwoaini/article/details/83503232)  
[MacPro 系统空间竟占90G，如何清理--OmniDiskSweeper](https://blog.csdn.net/seven_little/article/details/77505234)  
[Mac Pro硬盘清理，为啥我的系统占用如此之多的磁盘空间](https://blog.csdn.net/qq_28978893/article/details/83185227)  
[Mac 下清理硬盘空间大小 很实用哦。](https://blog.csdn.net/nynkl/article/details/78050495)  

