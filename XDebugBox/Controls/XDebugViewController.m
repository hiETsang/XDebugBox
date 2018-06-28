//
//  XDebugViewController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugViewController.h"
#import "XDebugContainerWindow.h"
#import "XDebugWindowManager.h"
#import "XDebugNavigationController.h"


static NSString *const kXDebugViewController = @"XDebugViewControllerKey";

@interface XDebugViewController ()

@end

@implementation XDebugViewController

+ (instancetype)debugViewController
{
    return [[self alloc] init];
}

- (UIWindow *)configWindow
{
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    XDebugContainerWindow *window = [[XDebugContainerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = window.windowLevel - 2;
    window.rootViewController = [[XDebugNavigationController alloc] initWithRootViewController:self];
    [window makeKeyAndVisible];
    [currentWindow makeKeyWindow];
    
    window.hidden = YES;
    window.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    [XDebugWindowManager saveWindow:window ForKey:kXDebugViewController];
    
    return window;
}


- (void)showWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXDebugViewController];
    if (!window) {
        window = [self configWindow];
    }
    
    window.hidden = NO;
}

- (void)removeWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXDebugViewController];
    if (!window) {
        return;
    }
    
    window.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
