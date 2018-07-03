//
//  XDebugNavigationController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugNavigationController.h"
#import "XMacros.h"

@interface XDebugNavigationController ()

@end

@implementation XDebugNavigationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configUI];
}

- (void)configUI
{
    self.view.frame = CGRectMake(kRatioWidth(26),kRatioHeight(167 * 0.5), kRatioWidth(323), kRatioHeight(500));
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = kRatioWidth(20);
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)dealloc
{
    
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
