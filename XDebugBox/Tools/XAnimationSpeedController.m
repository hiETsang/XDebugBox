//
//  XAnimationSpeedController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/3.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XAnimationSpeedController.h"

@interface XAnimationSpeedController ()

@property(nonatomic, strong) UISlider *slider;

@end

@implementation XAnimationSpeedController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.slider.frame = CGRectMake(0, 0, 200, 100);
    self.slider.center = self.view.center;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self.view addSubview:slider];
    self.slider = slider;
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
