## SEL和IMP


SEL:类成员方法的指针，但不同于C语言中的函数指针，函数指针直接保存了方法的地址，但SEL只是方法编号  
IMP:函数的指针  
我们的方法会编译成函数，通过SEL找到IMP，通过IMP找到具体的函数实现。  
SEL方法编号是通过Dispatch table表寻找到对应的IMP  


#### 参考
[SEL和IMP](https://www.jianshu.com/p/4b6e7cc98061)  
