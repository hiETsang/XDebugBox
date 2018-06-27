//
//  AppDelegate.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "AppDelegate.h"
#import "XSuspendedButton.h"
#import "ViewController.h"
#import "XRemoveSuspendedView.h"

@interface AppDelegate () <XSuspendedButtonDelegate>

@property(nonatomic, strong) XRemoveSuspendedView *suspendedView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    [[XSuspendedButton suspendedButtonWithDelegate:self] show];
    self.suspendedView = [XRemoveSuspendedView suspendedView];
    
    return YES;
}

- (void)suspendedButtonClick:(XSuspendedButton *)suspendedButton
{
    
}

-(void)suspendedButtonTouchBegin:(XSuspendedButton *)suspendedButton
{
    [self.suspendedView showWithAnimation];
}

-(void)suspendedButtonTouchMove:(XSuspendedButton *)suspendedButton
{
    if ([self removeSuspendedViewIsContainSuspendedButton:suspendedButton]) {
        [self.suspendedView layerAmplification];
    }else
    {
        [self.suspendedView layerNarrow];
    }
}

-(void)suspendedButtonTouchEnd:(XSuspendedButton *)suspendedButton
{
    if ([self removeSuspendedViewIsContainSuspendedButton:suspendedButton]) {
        [suspendedButton removeFromScreen];
        [self.suspendedView hideWithAnimation];
        [self.suspendedView setDidEndHideAnimation:^(XRemoveSuspendedView *suspendedView) {
            [suspendedView removeFromScreen];
        }];
    }else
    {
        [self.suspendedView hideWithAnimation];
    }
}

- (BOOL)removeSuspendedViewIsContainSuspendedButton:(XSuspendedButton *)suspendedButton
{
    //根据按钮圆心的距离和删除视图的圆心距离来判断是否抵达区域内
    CGPoint buttonCenter = [suspendedButton convertPoint:suspendedButton.center toView:UIApplication.sharedApplication.keyWindow];
    
    CGPoint suspendedCircleCenter = [self.suspendedView convertPoint:CGPointMake(CGRectGetMaxX(self.suspendedView.frame), CGRectGetMaxY(self.suspendedView.frame)) toView:UIApplication.sharedApplication.keyWindow];
    
    CGFloat buttonRadius = CGRectGetWidth(suspendedButton.frame) / 2.0;
    CGFloat suspendedCircleRadius = CGRectGetWidth(self.suspendedView.frame);
    
    CGFloat distance = sqrt(pow((suspendedCircleCenter.x - buttonCenter.x), 2) + pow((suspendedCircleCenter.y - buttonCenter.y), 2));
    
    return distance <= (suspendedCircleRadius - buttonRadius);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
