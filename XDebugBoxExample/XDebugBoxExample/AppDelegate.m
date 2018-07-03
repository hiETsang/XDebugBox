//
//  AppDelegate.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "XDebugBox.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    [XDebugBox open];
    [XDebugBox configActionArray:@[[XDebugDataModel debugModelWithTitle:@"新的一个" detail:@"好吧" autoClose:YES action:^(XDebugViewController *debugController){
        
    }]]];

    return YES;
}




@end
