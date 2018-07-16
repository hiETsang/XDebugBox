
![](https://github.com/hiETsang/XDebugBox/blob/master/XDebugBox.png)

XDebugBox是一个轻量级且安全，可视化的便于开发调试的工具。对项目无侵入，配置简单，并且可以自定义项目开发需求，致力于减少一些开发过程中不必要且耗时的操作。

## Screenshots
![](https://github.com/hiETsang/XDebugBox/blob/master/move.gif)

![](https://github.com/hiETsang/XDebugBox/blob/master/animation.gif)

![](https://github.com/hiETsang/XDebugBox/blob/master/cache.gif)

![](https://github.com/hiETsang/XDebugBox/blob/master/network.gif)
 
 
 
## Features
全局小圆点，可随意滑动，只在Debug模式下才会创建，点击打开调试窗口，滑动到右下角删除。
 
 
### 通用模块（内置常用功能）
* 全局动画速度调整
* 网络请求记录
* 缓存清理
* 当前所在ViewController类名
* 刷新通用模块列表


### 扩展模块（自定义项目所需功能）
例如：
* 自动登录某账号
* 跳转到个人中心或者app设置页面
* 显示当前所登录用户的本地缓存数据
* 所有能简化调试操作的功能
  
  
  
## Remind
* iOS 8.0 +
* Xcode 9 +
* ARC
  

  
## Installation
### 手动安装
下载XDebugBox，将XDebugBoxExample目录下的XDebugBox文件夹拖到项目中。

### cocopods
```
pod 'XDebugBox'
```

 

## Getting Started
1. 导入头文件`#import "XDebugBox.h"`

2. 开启调试小圆点`[XDebugBox open];`

3. 配置自定义的快捷工具

```objective-c
[XDebugBox configActionArray:
     
     @[[XDebugDataModel debugModelWithTitle:@"自动登陆" detail:@"登陆账号133********" autoClose:YES action:^(UIViewController *debugController){
        NSLog(@"自动登录 ---------> ");
    }],
       [XDebugDataModel debugModelWithTitle:@"跳转页面" detail:@"跳到JumpTestViewController" autoClose:YES action:^(UIViewController *debugController){
        [self jumpToViewController:[[JumpTestController alloc] init]];
    }]
       
       ]];
```

**建议新建一个类用于管理自定义的点击事件，参考XDebugBoxExample**
 
 
 
## Contact
https://github.com/hiETsang

https://xcanoe.top
