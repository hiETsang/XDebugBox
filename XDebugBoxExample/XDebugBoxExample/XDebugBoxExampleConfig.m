//
//  XDebugBoxExampleConfig.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/1.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugBoxExampleConfig.h"
#import "XDebugBox.h"

#import "JumpTestController.h"

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
       [XDebugDataModel debugModelWithTitle:@"跳转页面" detail:@"跳到JumpTestViewController" autoClose:YES action:^(UIViewController *debugController){
        [self jumpToViewController:[[JumpTestController alloc] init]];
    }],
       [XDebugDataModel debugModelWithTitle:@"当前页面" detail:@"显示当前的ViewController" autoClose:NO action:^(UIViewController *debugController){
        [XDebugBox showTip:NSStringFromClass([self currentViewController].class)];
    }]
       ]];
}



#pragma mark - actions

- (void)jumpToViewController:(UIViewController *)viewController {
    if ([self currentViewController].navigationController) {
        [[self currentViewController].navigationController pushViewController:viewController animated:YES];
    }else
    {
        [[self currentViewController] presentViewController:viewController animated:YES completion:nil];
    }
}

- (UIViewController*) topMostController
{
    UIViewController *topController = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])    topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

@end
