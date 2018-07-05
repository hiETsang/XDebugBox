//
//  AnimationTestController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/5.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "AnimationTestController.h"

@interface AnimationTestController ()

@property(nonatomic, strong) UIView *testView;

@end

@implementation AnimationTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AnimationTestController";
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0 - 50, 100, 100, 100)];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.testView.backgroundColor isEqual:[UIColor redColor]]) {
        [UIView animateWithDuration:1.0 animations:^{
            self.testView.transform = CGAffineTransformMakeTranslation(0, 200);
            self.testView.backgroundColor = [UIColor lightGrayColor];
        }];
    }else
    {
        [UIView animateWithDuration:1.0 animations:^{
            self.testView.transform = CGAffineTransformIdentity;
            self.testView.backgroundColor = [UIColor redColor];
        }];
    }
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
