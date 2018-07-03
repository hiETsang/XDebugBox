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
    [XDebugBox open];
    [XDebugBox configActionArray:
     @[[XDebugDataModel debugModelWithTitle:@"自动登陆" detail:@"登陆账号176********" autoClose:YES action:^(XDebugViewController *debugController){
        NSLog(@"自动登录 ---------> ");
    }],
       [XDebugDataModel debugModelWithTitle:@"个人信息" detail:@"跳到个人信息设置页面" autoClose:YES action:^(XDebugViewController *debugController){
        NSLog(@"跳转个人信息 ---------> ");
    }],
       [XDebugDataModel debugModelWithTitle:@"打印当前ViewController" detail:nil autoClose:YES action:^(XDebugViewController *debugController){
        NSLog(@"myViewController ---------> ");
    }]
       ]];
}

@end
