## AES+Base64加密

函数定义
``` swift
CCCryptorStatus CCCrypt(
    CCOperation op,         /* kCCEncrypt, etc. */
    CCAlgorithm alg,        /* kCCAlgorithmAES128, etc. */
    CCOptions options,      /* kCCOptionPKCS7Padding, etc. */
    const void *key,
    size_t keyLength,
    const void *iv,         /* optional initialization vector */
    const void *dataIn,     /* optional per op and alg */
    size_t dataInLength,
    void *dataOut,          /* data RETURNED here */
    size_t dataOutAvailable,
    size_t *dataOutMoved)
    API_AVAILABLE(macos(10.4), ios(2.0));
```

参数说明:  
1.`CCOperation op`  

2.`CCAlgorithm alg`


3.`CCOptions options`  
选择补码的方式，以及是否选择ECB模式，默认是CBC模式  


4.`const void *key`  
密钥


5.`size_t keyLength`
密钥的大小

6.`const void *iv`
偏移向量


7.`const void *dataIn`
要加解密的数据data.bytes


8.`size_t dataInLength`
要加解密数据的大小

9.`void *dataOut`
输出的数据，加解密后的数据写在这里

10.`size_t dataOutAvailable`
输出数据时需要的可用空间大小，数据缓冲区的大小

11.`size_t *dataOutMoved)`
操作成功之后，被写入的dataout的字节长度。


####参考
[iOS与Java后台AES+Base64数据加解密(附demo)](https://www.jianshu.com/p/db85399e8a76)  
[iOS加密：AES+Base64](https://github.com/BigYiza/AES-Base64)  
[iOS AES的加密解密](https://blog.csdn.net/u012907783/article/details/52484597)  
[关于AES256算法java端加密，ios端解密出现无法解密问题的解决方案](https://blog.csdn.net/pjk1129/article/details/8489550)  
[原:关于AES256算法java端加密，ios端解密出现无法解密问题的解决方案](https://my.oschina.net/nicsun/blog/95632)  
[解决iOS、Android、Java加解密不一致的问题（DES、AES）](https://blog.csdn.net/joeyon1985/article/details/48623641)  
[iOS AES解密遇到的问题](https://blog.csdn.net/weixin_34150830/article/details/87081201)  
[iOS AES+Base64解码出现乱码问题](https://www.jianshu.com/p/84167657279c)  

[iOS加解密最重要的干货：CCCrypt](https://www.jianshu.com/p/93466b31f675)  
[CCCrypt函数——iOS加解密必知](https://blog.csdn.net/q187543/article/details/89212553)  