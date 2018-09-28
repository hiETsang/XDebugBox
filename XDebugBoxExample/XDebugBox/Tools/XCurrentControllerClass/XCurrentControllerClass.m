//
//  XCurrentControllerClass.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/8.
//  Copyright © 2018 canoe. All rights reserved.
//

#import "XCurrentControllerClass.h"

@implementation XCurrentControllerClass

+ (UIViewController *)currentViewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    return [XCurrentControllerClass topViewControllerWithRootViewController:window.rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if (rootViewController == nil) {
        return nil;
    }
    
    if (rootViewController.presentedViewController) {
        return [XCurrentControllerClass topViewControllerWithRootViewController:rootViewController.presentedViewController];
    }else if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        return [XCurrentControllerClass topViewControllerWithRootViewController:[(UITabBarController *)rootViewController selectedViewController]];
    }else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        return [XCurrentControllerClass topViewControllerWithRootViewController:[(UINavigationController *)rootViewController visibleViewController]];
    }else
    {
        return rootViewController;
    }
}

+ (id)currentViewControllerAndSubViewControllers
{
    UIViewController *vc = [XCurrentControllerClass currentViewController];
    
    return [XCurrentControllerClass subViewControllerArrayWithController:vc];
}

+ (id)subViewControllerArrayWithController:(UIViewController *)viewController
{
    if (viewController.childViewControllers.count > 0) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < viewController.childViewControllers.count; i++) {
            [array addObject:[XCurrentControllerClass subViewControllerArrayWithController: viewController.childViewControllers[i]]];
        }
        [dict setValue:array forKey:NSStringFromClass([XCurrentControllerClass currentViewController].class)];
        return dict;
    }else
    {
        return NSStringFromClass(viewController.class);
    }
}

@end
