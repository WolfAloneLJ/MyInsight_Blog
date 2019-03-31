
#### 打包脚本

.sh文件  
```
#!/bin/sh

PROJECT_NAME="iEcoalAmb"
SCHEME_NAME="iEcoalAmb"
PROFILE_NAME="dongmeidashi_dis"

#删除
rm -rf "./bin"

#循环数组
WebServerUrls=("公司测试"  "东北亚测试"    "东北亚正式" )

for((i=0;i<${#WebServerUrls[@]};i++))
do

#清除
xcodebuild clean -workspace ${PROJECT_NAME}.xcworkspace -scheme ${SCHEME_NAME}

#修改plist
/usr/libexec/PlistBuddy -c "set :WebServerUrl ${WebServerUrls[$i]}" ./${PROJECT_NAME}/info.plist 

#生成archive
xcodebuild  archive -workspace ${PROJECT_NAME}.xcworkspace -scheme ${SCHEME_NAME} -destination generic/platform=iOS -archivePath bin/${PROJECT_NAME}_${WebServerUrls[$i]}.xcarchive

#生成ipa
xcodebuild -exportArchive -archivePath ./bin/${PROJECT_NAME}_${WebServerUrls[$i]}.xcarchive -exportPath bin/${PROJECT_NAME}_${WebServerUrls[$i]}.ipa -exportFormat ipa -exportProvisioningProfile ${PROFILE_NAME}

done

```
