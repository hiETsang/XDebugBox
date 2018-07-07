//
//  XAnimationSpeedController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/3.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XAnimationSpeedController.h"

@interface XAnimationSpeedController ()
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation XAnimationSpeedController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.slider.frame = CGRectMake(0, 0, 200, 100);
    self.slider.center = self.view.center;
    self.valueLabel.bounds = CGRectMake(0, 0, 100, 100);
    self.valueLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.slider.value = [UIApplication sharedApplication].keyWindow.layer.speed;
    
    [self.slider addTarget:self action:@selector(sliderValueChangged:) forControlEvents:UIControlEventValueChanged];
    
    self.valueLabel.text = [NSString stringWithFormat:@"%0.2f",self.slider.value];
}

- (void)sliderValueChangged:(UISlider *)slider {
    [UIApplication sharedApplication].keyWindow.layer.speed = slider.value;
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
}

- (IBAction)resetButtonClick:(UIButton *)sender {
    [UIApplication sharedApplication].keyWindow.layer.speed = 1.0;
    self.slider.value = [UIApplication sharedApplication].keyWindow.layer.speed;
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
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
