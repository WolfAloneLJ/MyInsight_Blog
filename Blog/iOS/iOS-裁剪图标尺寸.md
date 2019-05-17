### 裁剪图标尺寸

创建脚本shell文件。  
运行脚本文件 sh ./脚本文件.sh  
```
#!/bin/sh
filename="icon.png"
dirname="image"

filename_array=("iPhoneNoti_2.png" "iPhoneNoti_3.png" "iPhoneSetting_2.png" "iPhoneSetting_3.png" "iPhoneSpot_2.png" "iPhoneSpot_3.png" "iPhoneApp_2.png" "iPhoneApp_3.png" "iPadNoti_1.png" "iPadNoti_2.png" "iPadSetting_1.png" "iPadSetting_2.png" "iPadSpot_1.png" "iPadSpot_2.png" "iPadApp_1.png" "iPadApp_2.png" "iPadProApp_2.png" "AppStore.png")

size_array=("40" "60" "58" "87" "80" "120" "120" "180" "20" "40" "29" "58" "40" "80" "76" "152" "167" "1024" )
mkdir $dirname
for ((i=0;i<${#size_array[@]};++i)); do
mkdir $dirname
m_dir=$dirname/${filename_array[i]}
cp $filename $m_dir
sips -Z ${size_array[i]} $m_dir
done

# 使用注意:  
# 需要裁剪的icon图片建议使用512*512或者1024*1024的，命名为icon.png,且与脚本处在同一目录下；  
# filename_array与size_array是一一对应的，需要什么名字什么尺寸的图标在这里面改就行了！  

# 运行脚本 sh ./icon.sh 

```


