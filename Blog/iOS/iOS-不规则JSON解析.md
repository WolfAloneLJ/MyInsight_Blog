## iOS不规则JSON解析

ios只能解析标准格式的json 比如 "key":"value"这种形式，如果出现不带双引号的key或只有单引号的value，就是解析出错。这点不像安卓，可以强转。  

在项目中，我就遇到了这种不标准的json字符串需要解析.  

我的想法是，把不带引号的key加上双引号，再把带有单引号的value转换成双引号的value。通过正则表达式实现查找并替换。这里有一点需要注意的是，再写正则的时候需要考虑到有些value本身都带有特殊符号，如:,"'，所以我们写正则替换时需要兼容到这种情况，以下方法是我写的用于把不标准json字符串转换为标准json字符串：  


```
- (NSString *)changeJsonStringToTrueJsonString:(NSString *)json{
    // 将没有双引号的替换成有双引号的
    NSString *validString = [json stringByReplacingOccurrencesOfString:@"(\\w+)\\s*:([^A-Za-z0-9_])"
                                                     withString:@"\"$1\":$2"
                                                     options:NSRegularExpressionSearch
                                                     range:NSMakeRange(0, [json length])];
    //把'单引号改为双引号"
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])'"
                                                     withString:@"$1\""
                                                     options:NSRegularExpressionSearch
                                                     range:NSMakeRange(0, [validString length])];
    validString = [validString stringByReplacingOccurrencesOfString:@"'([:\\],\\}])"
                                                     withString:@"\"$1"
                                                     options:NSRegularExpressionSearch
                                                     range:NSMakeRange(0, [validString length])];
    
    //再重复一次 将没有双引号的替换成有双引号的
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])(\\w+)\\s*:"
                                                     withString:@"$1\"$2\":"
                                                     options:NSRegularExpressionSearch
                                                     range:NSMakeRange(0, [validString length])];
    return validString;
}
```

### 参考
[iOS JSON解析出错（解析非标准JSON）](https://www.jianshu.com/p/7c552d2f77c9)  
