//
//  XDebugBoxExampleConfig.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/1.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugBoxExampleConfig.h"
#import "XDebugBox.h"

@implementation XDebugBoxExampleConfig

- (void)configDebugBox
{
    //创建调试工具
    [XDebugBox open];
    
    //配置自定义的工具
    [XDebugBox configActionArray:
     @[[XDebugDataModel debugModelWithTitle:@"自动登陆" detail:@"登陆账号176********" autoClose:YES action:^(UIViewController *debugController){
        NSLog(@"自动登录 ---------> ");
    }],
       [XDebugDataModel debugModelWithTitle:@"个人信息" detail:@"跳到个人信息设置页面" autoClose:NO action:^(UIViewController *debugController){
        [XDebugBox showTip:@"跳转成功"];
    }],
       [XDebugDataModel debugModelWithTitle:@"当前ViewController" detail:nil autoClose:NO action:^(UIViewController *debugController){
        
    }]
       ]];
}

@end
