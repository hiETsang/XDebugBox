//
//  XSuspendedButtonController.m
//  LEVE
//
//  Created by canoe on 2017/7/7.
//  Copyright © 2019年 dashuju. All rights reserved.
//

#import "XSuspendedButtonController.h"

@interface XSuspendedButtonController ()

@end

@implementation XSuspendedButtonController

//修复在9.3系统上状态栏隐藏的bug
- (BOOL)prefersStatusBarHidden
{
    return NO;
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
