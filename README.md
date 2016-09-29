# LXMRulerView
A ruler View could be used as a value picker or a value displayer    

Color, lineDistance, spacing, margin, maxValue, minValue and some other property are customizable!     
Compatible with autoLayout and xib!

it will look like:    
![image](https://github.com/Phelthas/LXMRulerView/blob/master/Screenshots/rulerView.gif)       

[这里](http://www.cnblogs.com/Phelthas/p/5697166.html)有一篇总结    


## How to use   
1, cocoaPods    
在你的podfile中添加        
`pod 'LXMRulerView', '~> 1.3.1'`    
and run `pod update` or `pod install`    
2, manual    
add `LXMRulerView.h`and `LXMRulerView.m` to your project


## Update
1.3.1    修复从xib初始化的时候初始值不对的问题    
1.3.0    改用CALayer的方式实现，不再用drawRect的方式；drawRect的方式太占内存了       
1.2.0    加入accuracy属性，支持尺子的一格代表不同的值    
1.1.0    支持autolayout，支持从xib初始化    




## License
LXMRulerView is provided under the MIT license. See LICENSE file for details.
