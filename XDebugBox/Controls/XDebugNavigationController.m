//
//  XDebugNavigationController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugNavigationController.h"

#define kXRatioHeight(h) (h) * ([UIScreen mainScreen].bounds.size.height/667.0)   //适配高度
#define kXRatioWidth(w) (w) * ([UIScreen mainScreen].bounds.size.width/375.0)     //适配宽度

@interface XDebugNavigationController ()

@end

@implementation XDebugNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configUI];
}

- (void)configUI
{
    self.view.frame = CGRectMake(kXRatioWidth(26),kXRatioHeight(167 * 0.5), kXRatioWidth(323), kXRatioHeight(500));
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = kXRatioWidth(20);
    self.view.backgroundColor = [UIColor whiteColor];
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
