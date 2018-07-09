//
//  XCurrentControllerClass.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/8.
//  Copyright © 2018 canoe. All rights reserved.
//

#import "XCurrentControllerClass.h"

@implementation XCurrentControllerClass

+ (UIViewController*) topMostController
{
    UIViewController *topController = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])    topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

+ (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [XCurrentControllerClass topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

@end
