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
#import "XDebugSwitchView.h"
#import "XMacros.h"


static NSString *const kXDebugViewController = @"XDebugViewControllerKey";

@interface XDebugViewController ()<UIGestureRecognizerDelegate>

@end

@implementation XDebugViewController

#pragma mark - public

+ (instancetype)debugViewController
{
    return [[self alloc] init];
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
    [XDebugWindowManager removeWindowForKey:kXDebugViewController];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI
{
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    titleImageView.image = [UIImage imageNamed:@"logo"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 34, 34)];
    [view addSubview:titleImageView];
    self.navigationItem.titleView = view;
    
    XDebugSwitchView *switchView = [[XDebugSwitchView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, kRatioHeight(57))];
    [self.view addSubview:switchView];
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
    window.userInteractionEnabled = YES;
    window.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [XDebugWindowManager saveWindow:window ForKey:kXDebugViewController];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDebugWindow:)];
    tap.delegate = self;
    [window addGestureRecognizer:tap];
    
    return window;
}

#pragma mark - actions

-(void)tapDebugWindow:(UITapGestureRecognizer *)tap
{
    if (self.tapWindow) {
        self.tapWindow(self);
    }
}


#pragma mark - gestureDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    return !CGRectContainsPoint(self.view.bounds, point);
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
