### CommonCrypto加密
### AES128加密解密（swift版本）

#### 导入库：
```
首先，需要导入一个系统库：（swift需要写在桥接文件里）
#import <CommonCrypto/CommonCrypto.h>
```
#### 基本方法：
```
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
```
这是加密和解密的一个基本的方法，其中：

```
//***操作***//
//opterantion传值: (CCOperation)
//kCCEncrypt = 0    --> 加密
//kCCDecrypt        --> 解密
//***设置***//
//options传值: (CCOptions)
//kCCOptionPKCS7Padding   = 0x0001      --> 需要iv
//kCCOptionECBMode        = 0x0002      --> 不需要iv
//***类型***//
//algorithm传值: (CCAlgorithm)
//kCCKeySizeAES128          = 16    --> AES128
//kCCKeySizeAES192          = 24    --> AES192
//kCCKeySizeAES256          = 32    --> AES256
//kCCKeySizeDES             = 8     --> DES
//kCCKeySize3DES            = 24    --> 3DES
//kCCKeySizeMinCAST         = 5     --> MIN_CAST
//kCCKeySizeMaxCAST         = 16    --> MAX_CAST
//kCCKeySizeMinRC4          = 1     --> MIN_RC4
//kCCKeySizeMaxRC4          = 512   --> MAX_RC4
//kCCKeySizeMinRC2          = 1     --> MIN_RC2
//kCCKeySizeMaxRC2          = 128   --> MAX_RC2
//kCCKeySizeMinBlowfish     = 8     --> MIN_BLOWFISH
//kCCKeySizeMaxBlowfish     = 56    --> MAX_BLOWFISH
//***其他类型参数***//
//key：加密密钥（指针）  -------  keyLength：密钥长度
//dataIn：要加密的数据（指针）  ------  dataInLength：数据的长度
//dataOut：加密后的数据（指针）  ------  dataOutAvailable：数据接收的容器长度
//dataOutMoved：数据接收
//*** size_t 和 Int 有区别：
//size_t是无符号的，并且是平台无关的，表示0-MAXINT的范围;
//Int 对于 swift 是有符号的
//***const void * 和 void * 都是指针类型，分别对应swift中UnsafePointer<UInt8>
//和UnsafeMutablePointer<UInt8>，而最新的swift版本中分别对应UnsafeRawPointer
//和UnsafeMutableRawPointer
```
#### 代码：
Data扩展
```
enum CryptError: Error {
    case noIV
    case cryptFailed
    case notConvertTypeToData
}

extension Data {
///***********加密&解密************///
//===>>>>>>>AES128
func dataCryptAES128(_ options: CCOptions?, _ operation: CCOperation, _ keyData: Data, _ iv: Data?)  throws -> Data {
    return try self.dataCrypt(options ?? CCOptions(kCCOptionECBMode),
                              operation,
                              keyData,
                              iv,
                              CCAlgorithm(kCCAlgorithmAES128))
}
//===>>>>>>>基本方法
func dataCrypt(_ options: CCOptions, _ operation: CCOperation, _ keyData: Data, _ iv: Data?, _ algorithm: UInt32) throws -> Data {
    
    if iv == nil && (options & CCOptions(kCCOptionECBMode)) == 0 {
        print("Error in crypto operation: dismiss iv!")
        throw(CryptError.noIV)
    }
    //key
    let keyBytes = keyData.bytes()
    let keyLength = size_t(kCCKeySizeAES128)
    //data(input)
    let dataBytes = self.bytes()
    let dataLength = size_t(self.count)
    //data(output)
    var buffer = Data(count: dataLength + Int(kCCBlockSizeAES128))
    let bufferBytes = buffer.mutableBytes()
    let bufferLength = size_t(buffer.count)
    //iv
    let ivBuffer: UnsafePointer<UInt8>? = iv == nil ? nil : iv!.bytes()

    var bytesDecrypted: size_t = 0
    
    let cryptState = CCCrypt(operation,
                             algorithm,
                             options,
                             keyBytes,
                             keyLength,
                             ivBuffer,
                             dataBytes,
                             dataLength,
                             bufferBytes,
                             bufferLength,
                             &bytesDecrypted)
    
    guard Int32(cryptState) == Int32(kCCSuccess) else {
        print("Error in crypto operation: \(cryptState)")
        throw(CryptError.cryptFailed)
    }

    buffer.count = bytesDecrypted
    return buffer
}

//===>>>>>>>Help Funcations<<<<<<<===//
func bytes() -> UnsafePointer<UInt8> {
    return self.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> UnsafePointer<UInt8> in
        return bytes
    }
}

mutating func mutableBytes() -> UnsafeMutablePointer<UInt8> {
    return self.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> in
        return bytes
    }
}
}
```
String扩展
```
//AES128加密之后,base64编码
func aes128AndBase64(_ options: CCOptions?, _ operation: CCOperation, _ keyData: Data, _ iv: Data?) throws -> String {
    guard let data = self.data(using: .utf8) else {
        throw(CryptError.notConvertTypeToData)
    }
    
    let aesData = try data.dataCryptAES128(options,
                                           operation,
                                           keyData,
                                           iv)
    
    return aesData.base64EncodedString()
}
```
最后附上一个MD5的加密方法（也是对于String的扩展）
```
//MD5加密

```

#### 参考:
[AES128加密解密（swift版本）](https://www.jianshu.com/p/8e94136857be)  
[SwCrypt](https://github.com/soyersoyer/SwCrypt)  
[CommonCrypto in Swift](https://github.com/DigitalLeaves/CommonCrypto-in-Swift)    
[如何在 Swift 中使用 CommonCrypto 类进行加密(I)](https://blog.csdn.net/cmbbill/article/details/48442879)  


