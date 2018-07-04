//
//  ViewController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"XDebugBoxExample";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [self.view addSubview:tf];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = CGRectMake(0, 0, 100, 100);
    } completion:^(BOOL finished) {
        self.imageView.frame = self.view.bounds;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
