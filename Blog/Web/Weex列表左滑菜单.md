## Weex下列表左滑菜单

```
<template>
    <div style="flex:1;width: 750px; background-color: #F7F7F7">
 
        <div style="height: 100px; width: 750px; background-color: #0094ff; justify-content: center">
            <text style="font-size: 40px;color: cornsilk; margin-left: 30px">侧滑deom</text>
        </div>
 
        <list style="flex: 1; width: 710px; margin-left: 20px;">
            <cell v-for="(item,index) in data">
 
                <div style="margin-top: 20px; margin-bottom: 20px; width: 710px; height: 160px; border-radius: 10px; background-color: #ffffff">
 
                    <div style="flex-direction: row; width: 870px" ref="itemDev" @swipe="handleSwipe($event,index)">
 
                        <div style="justify-content: center; width: 710px; height: 160px; background-color: #ffffff">
                            <text style="color: #666666; font-size: 30px">{{item}}</text>
                        </div>
 
 
                        <div style="background-color: #ff0000; width: 160px; height: 160px; justify-content: center; align-items: center" @click="removeItem(index)">
                            <text style="font-size: 30px; color:#ffffff">删除</text>
                        </div>
 
                    </div>
 
                </div>
 
            </cell>
        </list>
    </div>
</template>
```






#### 参考:
[weex下实现列表项左滑菜单](https://blog.csdn.net/kormondor/article/details/79660218)  
[weex列表侧滑删除](https://www.jianshu.com/p/cd17c57f8681)  



