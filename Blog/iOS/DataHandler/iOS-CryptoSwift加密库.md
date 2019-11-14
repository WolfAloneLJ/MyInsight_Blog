###  iOS 第三方加密库CryptoSwift使用详解3

三、CRC 校验码计算
CRC 即循环冗余校验码（Cyclic Redundancy Check）：是数据通信领域中最常用的一种查错校验码，其特征是信息字段和校验字段的长度可以任意选定。
循环冗余检查（CRC）是一种数据传输检错功能，对数据进行多项式计算，并将得到的结果附在帧的后面，接收设备也执行类似的算法，以保证数据传输的正确性和完整性。
```swift
/*** 计算字节数组的CRC值 ***/
let bytes:Array<UInt8> = [0x01, 0x02, 0x03]
let crc1 = bytes.crc16() //41232
let crc2 = bytes.crc32() //1438416925
 
/*** 计算Data的CRC值 ***/
let data = Data(bytes: [0x01, 0x02, 0x03])
let crc3 = data.crc16() //2 bytes
let crc4 = data.crc32() //2 bytes
 
/*** 计算字符串的CRC值 ***/
let crc5 = "hangge.com".crc16() //90e7
let crc6 = "hangge.com".crc32() //7eeb79d1
```

四、消息认证码（MAC）计算
1，消息认证码（MAC）介绍
消息认证码是指在密码学中，通信实体双方使用的一种验证机制，保证消息数据完整性的一种工具。
其构造方法由 M.Bellare 提出，安全性依赖于 Hash 函数，故也称带密钥的 Hash 函数。
消息认证码是基于密钥和消息摘要所获得的一个值，可用于数据源发认证和完整性校验。
 
2，计算 HMAC
HMAC（Hashed Message Authentication Code）中文名叫做：散列消息身份验证码。关于它的具体介绍可以参考我之前写的这篇文章：Swift - 如何实现字符串的HMAC_SHA1加密
当时使用的是 iOS SDK 自带的 CommonCrypto 库来实现，如果我们使用 CryptoSwift 的话就更简单了。

（1）下面是一个进行 HMAC_SHA1 计算的样例。
```swift
let str = "欢迎访问hangge.com"
let key = "hangge"
let hmac = try! HMAC(key: key.bytes, variant: .sha1).authenticate(str.bytes)
 
print("原始字符串：\(str)")
print("key：\(key)")
print("HMAC运算结果：\(hmac.toHexString())")
```
运行结果如下：  
原文:Swift - 第三方加密库CryptoSwift使用详解2（CRC、MAC、PBKDF2）

（2）除了 SHA1，我们还可以使用其它算法比如 MD5，SHA256 等
```swift
try! HMAC(key: key.bytes, variant: .md5).authenticate(str.bytes)
try! HMAC(key: key.bytes, variant: .sha1).authenticate(str.bytes)
try! HMAC(key: key.bytes, variant: .sha256).authenticate(str.bytes)
try! HMAC(key: key.bytes, variant: .sha384).authenticate(str.bytes)
try! HMAC(key: key.bytes, variant: .sha512).authenticate(str.bytes)
```
3，计算 Poly1305
Poly1305 是 Daniel.J.Bernstein 创建的消息认证码，可用于检测消息的完整性和验证消息的真实性，现常在网络安全协议（SSL/TLS）中与 salsa20 或 ChaCha20 流密码结合使用。
Poly1305 消息认证码的输入为 32 字节（256bit）的密钥和任意长度的消息比特流，经过一系列计算生成 16 字节（128bit）的摘要。
使用代码如下，这里我们还是使用一个字符串来生成一个 32 字节的密钥。
```swift
let str = "欢迎访问hangge.com"
let key = "hg012345678901234567890123456789"
let mac = try! Poly1305(key: key.bytes).authenticate(str.bytes)
 
print("原始字符串：\(str)")
print("key：\(key)")
print("Poly1305运算结果：\(mac.toHexString())")
```
运行结果如下：
原文:Swift - 第三方加密库CryptoSwift使用详解2（CRC、MAC、PBKDF2）

五、PBKDF2 加密  
1，给密码加盐（Salt）  
（1）什么是加盐?  
在密码学中，通过在密码任意固定位置插入特定的字符串，让散列后的结果和使用原始密码的散列结果不相符，这种过程称之为“加盐”。  
  
（2）为什么要加盐?  
过去我们为了防止因为数据库的泄露，而造成里面保存的用户名和密码的泄露。通常的做法是不存储明文密码，而是存储加密后的密码，比如存储通过 MD5 或 SHA1 加密后的密文。然而这种方式也是不安全的，只要枚举出所有的常用密码，做成一个索引表，就可以推出来原始密码，这张索引表也被叫做“彩虹表”（之前 csdn 600 万用户明文密码就是一个很好的素材）。
而通过加盐，我们在原始密码加上特定的随机字符串字符串，同时再灵活地调整插入的位置。这样即便数据库泄露了，由于密码都是加了 Salt 之后的散列，使用数据字典已经无法直接匹配，明文密码被破解出来的概率也大大降低。即使是暴力破解也需要付出很大的时间成本。
```
md5(md5(password) + salt)
SHA512(SHA512(password) + salt)
bcrypt(SHA512(password), salt, cost)
```

（3）加盐的注意事项
盐值不要太短。为了使攻击者无法构造包含所有可能盐值的查询表，盐值越长越好（至少为 8 字节）。一个好的做法是使用和哈希函数输出的字符串等长的盐值，比如 SHA256 算法的输出是 256bits（32 bytes)，那么盐值也至少应该是 32 个随机字节。
盐要求的是随机性，采用固定盐在数学上等于没加盐。比如我们对用户密码加密，每个用户的盐都应该是不同的，数据库可以这样存储：
 
username | password | salt   
 :-: | :-: | :-:   
happylong | ASDSSFDSFassdQDd | sdsSDS32
 

注意：不建议将用户名作为盐值。  
尽管在一个网站中用户名是唯一的，但是它们是可预测的，并且经常重复用于其他服务中。攻击者可以针对常见用户名构建查询表，然后对用户名盐值哈希发起进攻。

2，PBKDF2 介绍  
PBKDF2（Password-Based Key Derivation Function）是一个用来导出密钥的函数，常用于生成加密的密码。  
它的基本原理是通过一个伪随机函数（例如 HMAC 函数），把明文和一个盐值作为输入参数，然后重复进行运算，并最终产生密钥。  
如果重复的次数足够大，破解的成本就会变得很高。而盐值的添加也会增加“彩虹表”攻击的难度。  
  
3，使用 PBKDF2 给密码加盐  
（1）我们可以使用 CryptoSwift 提供的 PKCS5.PBKDF2() 函数进行加盐计算，该函数参数如下：  
password：用来生成密钥的原始密码  
salt：加密用的盐值  
iterations：重复计算的次数。默认值：4096  
keyLength：期望得到的密钥的长度。默认值：不指定  
variant：加密使用的伪随机函数。默认值：sha256  

（2）这里我们使用该函数对一个指定密码加盐，其它参数不改变，都使用默认值。  
```swift
let password = "hangge2017"
let salt = "Ut3Opm78U76VbwoP4Vx6UdfN234Esaz9"
let pbkdf2 = try! PKCS5.PBKDF2(password: password.bytes, salt: salt.bytes).calculate()
 
print("原始密码：\(password)")
print("Salt：\(salt)")
print("加盐运算结果：\(pbkdf2.toHexString())")
运行结果如下：
原文:Swift - 第三方加密库CryptoSwift使用详解2（CRC、MAC、PBKDF2）

（3）可以指定生成的密钥长度，比如这里设置为 4 个字节。
```swift
let password = "hangge2017"
let salt = "Ut3Opm78U76VbwoP4Vx6UdfN234Esaz9"
let pbkdf2 = try! PKCS5.PBKDF2(password: password.bytes, salt: salt.bytes,
                               keyLength: 4).calculate()
 
print("原始密码：\(password)")
print("Salt：\(salt)")
print("加盐运算结果：\(pbkdf2.toHexString())")
```
那么得到密钥可以转为 8 个字符的字符串：
原文:Swift - 第三方加密库CryptoSwift使用详解2（CRC、MAC、PBKDF2）

（4）下面我们改用 md5 算法来进行加盐计算。
```swift
let password = "hangge2017"
let salt = "Ut3Opm78U76VbwoP4Vx6UdfN234Esaz9"
let pbkdf2 = try! PKCS5.PBKDF2(password: password.bytes, salt: salt.bytes, iterations: 4096,
                               variant: .md5).calculate()
 
print("原始密码：\(password)")
print("Salt：\(salt)")
print("加盐运算结果：\(pbkdf2.toHexString())")
```
运行结果如下：  

### AES加密
1，AES 介绍  
高级加密标准（英语：Advanced Encryption Standard，缩写：AES），在密码学中又称 Rijndael 加密法，是美国联邦政府采用的一种区块加密标准。
该标准是用来替代原先的 DES，现已经被多方分析且广为全世界所使用，成为对称密钥加密中最流行的算法之一。    
AES 采用对称分组密码体制，加密数据块分组长度必须为 128 比特，密钥长度可以是 128 比特、192 比特、256 比特中的任意一个（如果数据块及密钥长度不足时，会补齐）  
2，加密模式介绍  
AES 作为一种分组加密算法为了适应不同的安全性要求和传输需求允许在多种不同的加密模式下工作：

（1）ECB 模式（电子密码本模式：Electronic codebook）  
ECB 是最简单的块密码加密模式，加密前根据加密块大小（如 AES 为 128 位）分成若干块，之后将每块使用相同的密钥单独加密，解密同理。  
ECB 模式由于每块数据的加密是独立的因此加密和解密都可以并行计算。  
ECB 模式最大的缺点是相同的明文块会被加密成相同的密文块，这种方法在某些环境下不能提供严格的数据保密性。  

（2）CBC 模式（密码分组链接：Cipher-block chaining）
CBC 模式对于每个待加密的密码块在加密前会先与前一个密码块的密文异或然后再用加密器加密。第一个明文块与一个叫初始化向量的数据块异或。  
CBC 模式相比 ECB 有更高的保密性，但由于对每个数据块的加密依赖于前一个数据块的加密，所以加密无法并行。  
CBC 模式与 ECB 一样在加密前需要对数据进行填充，不是很适合对流数据进行加密。   

（3）CTR 模式（计算器模式：Counter）    
计算器模式不常见，在 CTR 模式中， 有一个自增的算子，这个算子用密钥加密之后的输出和明文异或的结果得到密文，相当于一次一密。  
这种加密方式简单快速，安全可靠，而且可以并行加密。  
但是在计算器不能维持很长的情况下，密钥只能使用一次。  

（4）CFB 模式（密文反馈：Cipher feedback）    
与 ECB 和 CBC 模式只能够加密块数据不同，CFB 能够将块密文（Block Cipher）转换为流密文（Stream Cipher）。  
CFB 的加密工作分为两部分：先将前一段加密得到的密文再加密；接着将第 1 步加密得到的数据与当前段的明文异或。   
由于加密流程和解密流程中被块加密器加密的数据是前一段密文，因此即使明文数据的长度不是加密块大小的整数倍也是不需要填充的，这保证了数据长度在加密前后是相同的。
CFB 模式非常适合对流数据进行加密，解密可以并行计算。  

（5）OFB 模式（输出反馈：Output feedback）   
OFB 是先用块加密器生成密钥流（Keystream），然后再将密钥流与明文流异或得到密文流，解密是先用块加密器生成密钥流，再将密钥流与密文流异或得到明文，由于异或操作的对称性所以加密和解密的流程是完全一样的。  
OFB 与 CFB 一样都非常适合对流数据的加密。  
OFB 由于加密和解密都依赖与前一段数据，所以加密和解密都不能并行。  
  
3，关于密钥长度  
（1）在进行 AES 加密时，CryptoSwift 会根据密钥的长度自动选择对应的加密算法（AES128, AES192, AES256）  
AES-128 = 16 bytes
AES-192 = 24 bytes
AES-256 = 32 bytes

（2）这里我们以 ECB 模式为例。由于密钥为 16 个字符（字节），则自动采用 aes128 加密。
```swift
do {
    let str = "欢迎访问 hangge.com"
    print("原始字符串：\(str)")
     
    let key = "hangge.com123456"
    print("key密钥：\(key)")
     
    //使用AES-128-ECB加密模式
    let aes = try AES(key: key.bytes, blockMode: ECB())
     
    //开始加密
    let encrypted = try aes.encrypt(str.bytes)
    let encryptedBase64 = encrypted.toBase64() //将加密结果转成base64形式
    print("加密结果(base64)：\(encryptedBase64!)")
     
    //开始解密1（从加密后的字符数组解密）
    let decrypted1 = try aes.decrypt(encrypted)
    print("解密结果1：\(String(data: Data(decrypted1), encoding: .utf8)!)")
     
    //开始解密2（从加密后的base64字符串解密）
    let decrypted2 = try encryptedBase64?.decryptBase64ToString(cipher: aes)
    print("解密结果2：\(decrypted2!)")
} catch { }
```
运行结果如下：  
原文:Swift - 第三方加密库CryptoSwift使用详解3（AES加密与解密）

（3）如果密钥长度不够 16、24 或 32 字节，可以使用 zeroPadding 将其补齐至 blockSize 的整数倍。
zeroPadding 补齐规则：
将长度补齐至 blockSize 参数的整数倍。比如我们将 blockSize 设置为 AES.blockSize（16）。
如果长度小于 16 字节：则尾部补 0，直到满足 16 字节。
如果长度大于等于 16 字节，小于 32 字节：则尾部补 0，直到满足 32 字节。
如果长度大于等于 32 字节，小于 48 字节：则尾部补 0，直到满足 48 字节。 以此类推......
这里还是以 ECB 模式为例，假设我们密钥只有 9 个字节，通过 zeroPadding 补齐到 16 个字节。
```swift
do {
    let str = "欢迎访问 hangge.com"
    print("原始字符串：\(str)")
     
    let key = "hangge666"
    print("key密钥：\(key)")
     
    //使用AES-128-ECB加密模式
    let aes = try AES(key: Padding.zeroPadding.add(to: key.bytes, blockSize: AES.blockSize),
                      blockMode: ECB())
     
    //开始加密
    let encrypted = try aes.encrypt(str.bytes)
    let encryptedBase64 = encrypted.toBase64() //将加密结果转成base64形式
    print("加密结果(base64)：\(encryptedBase64!)")
     
    //开始解密1（从加密后的字符数组解密）
    let decrypted1 = try aes.decrypt(encrypted)
    print("解密结果1：\(String(data: Data(decrypted1), encoding: .utf8)!)")
     
    //开始解密2（从加密后的base64字符串解密）
    let decrypted2 = try encryptedBase64?.decryptBase64ToString(cipher: aes)
    print("解密结果2：\(decrypted2!)")
} catch { }
```
运行结果如下：  
原文:Swift - 第三方加密库CryptoSwift使用详解3（AES加密与解密）

4，CBC 模式的便捷写法
（1）我们知道使用 CBC 模式加密时，除了提供一个密钥（key）外，还需要一个密钥偏移量（iv）。这个 Cipher 的完整写法如下：
```swift
do {
    let str = "欢迎访问 hangge.com"
    print("原始字符串：\(str)")
     
    let key = "hangge.com123456"
    print("key密钥：\(key)")
     
    let iv = "1234567890123456"
    print("密钥偏移量：\(iv)")
     
    //使用AES-128-CBC加密模式
    let aes = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
     
    //开始加密
    let encrypted = try aes.encrypt(str.bytes)
    let encryptedBase64 = encrypted.toBase64() //将加密结果转成base64形式
    print("加密结果(base64)：\(encryptedBase64!)")
     
    //开始解密1（从加密后的字符数组解密）
    let decrypted1 = try aes.decrypt(encrypted)
    print("解密结果1：\(String(data: Data(decrypted1), encoding: .utf8)!)")
     
    //开始解密2（从加密后的base64字符串解密）
    let decrypted2 = try encryptedBase64?.decryptBase64ToString(cipher: aes)
    print("解密结果2：\(decrypted2!)")
} catch { }
```
运行结果如下：  
原文:Swift - 第三方加密库CryptoSwift使用详解3（AES加密与解密）

（2）CBC 模式的 Cipher 还可以这么写，效果同上面的那个是一样的。
```swift
do {
    let str = "欢迎访问 hangge.com"
    print("原始字符串：\(str)")
     
    let key = "hangge.com123456"
    print("key密钥：\(key)")
     
    let iv = "1234567890123456"
    print("密钥偏移量：\(iv)")
     
    //使用AES-128-CBC加密模式
    let aes = try AES(key: key, iv: iv)
     
    //开始加密
    let encrypted = try aes.encrypt(str.bytes)
    let encryptedBase64 = encrypted.toBase64() //将加密结果转成base64形式
    print("加密结果(base64)：\(encryptedBase64!)")
     
    //开始解密1（从加密后的字符数组解密）
    let decrypted1 = try aes.decrypt(encrypted)
    print("解密结果1：\(String(data: Data(decrypted1), encoding: .utf8)!)")
     
    //开始解密2（从加密后的base64字符串解密）
    let decrypted2 = try encryptedBase64?.decryptBase64ToString(cipher: aes)
    print("解密结果2：\(decrypted2!)")
} catch { }
```

5，随机生成密钥偏移量
除了 ECB 模式外，其它模式不仅需要提供密钥（key），还需要一个密钥偏移量（iv）。如果觉得自己定义 iv 麻烦，可以通过 AES.randomIV() 方法来自动生成。
```swift
//创建一个16字节的随机密钥偏移量
let iv = AES.randomIV(AES.blockSize)
print(iv)
```
运行结果如下：  
原文:Swift - 第三方加密库CryptoSwift使用详解3（AES加密与解密）

6，String 的加密与解密
（1）上面的样例中，我们都是先定义一个 Cipher，然后使用这个 Cipher 的 encrypt 和 decrypt 方法对字符串进行加密与解密。但这过程中我们还需要手动进行一些数据转换工作：
加密时需要先将字符串转为字节数组（[UInt8]）。加密后又需要将结果从字节数组转为 base64 的字符串形式。
解密后同样需要将结果从字节数组转为字符串形式。

```swift
//使用AES-128-CBC加密模式的Cipher
let aes = try AES(key: key, iv: iv)
 
//方式一
let str = "欢迎访问 hangge.com"
             
let encrypted = try aes.encrypt(str.bytes)
print("加密结果(base64)：\(encrypted.toBase64()!)")
 
let decrypted = try aes.decrypt(encrypted)
print("解密结果：\(String(data: Data(decrypted), encoding: .utf8)!)")
```
   
（2）而 CryptoSwift 其实对 String 做了扩展，增加了许多加密解密的相关方法。我们只需要传入 Cipher 即可，不再需要进行这些数据转换工作了。
```swift
//使用AES-128-CBC加密模式的Cipher
let aes = try AES(key: key, iv: iv)
 
//方式二
let str = "欢迎访问 hangge.com"
 
let encrypted = try str.encryptToBase64(cipher: aes)!
print("加密结果(base64)：\(encrypted)")
             
let decrypted = try encrypted.decryptBase64ToString(cipher: aes)
print("解密结果：\(decrypted)")
```

7，增量更新
使用 Cryptor 实例可以进行增量操作，即每次只加密或解密一部分数据，这样对于大文件可以有效地节省内存占用。   
```swift
do {
    //创建一个用于增量加密的Cryptor实例
    var encryptor = try AES(key: "hangge.com123456", iv: "drowssapdrowssap").makeEncryptor()
     
    var ciphertext = Array<UInt8>()
    //合并每个部分的结果
    ciphertext += try encryptor.update(withBytes: Array("欢迎访问".utf8))
    ciphertext += try encryptor.update(withBytes: Array(" ".utf8))
    ciphertext += try encryptor.update(withBytes: Array("hangge.com".utf8))
    //结束
    ciphertext += try encryptor.finish()
     
    //输出完整的结果（base64字符串形式）
    print(ciphertext.toBase64()!)
} catch {
    print(error)
}
```  
运行结果如下：



8，补码方式（padding）
（1）默认情况下，CryptoSwift 使用 PKCS7 进行填充。比如下面两个定义方式是一样的。
1
2
3
let aes1 = try AES(key: key, blockMode: CBC(iv: iv))
         
let aes2 = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)

（2）我们也可以根据需求改成其它的填充方式。具体有：
pkcs5
pkcs7
zeroPadding
noPadding


### RSA加密


### 参考:
[RSA使用NSString格式公钥加密](https://github.com/muzipiao/RSAEncrypt)         
[iOS端RSA加密](https://www.jianshu.com/p/54c386275c08)     

[Swift - 第三方加密库CryptoSwift使用详解3（AES加密与解密）](https://www.hangge.com/blog/cache/detail_1869.html)  





