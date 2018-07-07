//
//  XDebugSwitchView.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugSwitchView.h"
#import "XMacros.h"

@interface XDebugSwitchView ()

@property(nonatomic, strong) UIButton *normalButton;
@property(nonatomic, strong) UIButton *extensionButton;

@end

@implementation XDebugSwitchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normalButton.frame = CGRectMake(kRatioWidth(43), kRatioHeight(12), kRatioWidth(102), kRatioHeight(27));
    self.normalButton.backgroundColor = [UIColor whiteColor];
    self.normalButton.layer.cornerRadius = kRatioHeight(13.5);
    [self.normalButton setTitle:@"通用" forState:UIControlStateNormal];
    [self.normalButton setTitleColor:RGBA(115, 149, 247, 1) forState:UIControlStateSelected];
    [self.normalButton setTitleColor:RGBA(180, 182, 189, 1) forState:UIControlStateNormal];
    self.normalButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    [self.normalButton addTarget:self action:@selector(switchTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    self.normalButton.layer.shadowColor = RGBA(47, 53, 62, 0.08).CGColor;
    self.normalButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.normalButton.layer.shadowRadius = 8;
    self.normalButton.layer.shadowOpacity = 1.0;
    [self addSubview:self.normalButton];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.normalButton.bounds];
    self.normalButton.layer.shadowPath = path.CGPath;
    
    self.extensionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.extensionButton.frame = CGRectMake(kRatioWidth(179), kRatioHeight(12), kRatioWidth(102), kRatioHeight(27));
    self.extensionButton.backgroundColor = [UIColor whiteColor];
    self.extensionButton.layer.cornerRadius = kRatioHeight(13.5);
    [self.extensionButton setTitle:@"扩展" forState:UIControlStateNormal];
    [self.extensionButton setTitleColor:RGBA(115, 149, 247, 1) forState:UIControlStateSelected];
    [self.extensionButton setTitleColor:RGBA(180, 182, 189, 1) forState:UIControlStateNormal];
    self.extensionButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    [self.extensionButton addTarget:self action:@selector(switchTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.extensionButton];
    self.extensionButton.layer.shadowColor = RGBA(47, 53, 62, 0.08).CGColor;
    self.extensionButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.extensionButton.layer.shadowRadius = 8;
    self.extensionButton.layer.shadowOpacity = 1.0;
    UIBezierPath *extensionPath = [UIBezierPath bezierPathWithRect:self.extensionButton.bounds];
    self.extensionButton.layer.shadowPath = extensionPath.CGPath;
    
    self.type = XDebugSwitchViewTypeNormal;
    self.normalButton.selected = YES;
    self.extensionButton.selected = NO;
    self.normalButton.layer.shadowOpacity = 1.0;
    self.extensionButton.layer.shadowOpacity = 0.0;
}

- (void)setType:(XDebugSwitchViewType)type
{
    if (_type == type) return;
    
    _type = type;
    if (type == XDebugSwitchViewTypeNormal) {
        self.normalButton.selected = YES;
        self.extensionButton.selected = NO;
        self.normalButton.layer.shadowOpacity = 1.0;
        self.extensionButton.layer.shadowOpacity = 0.0;
    }else
    {
        self.normalButton.selected = NO;
        self.extensionButton.selected = YES;
        self.normalButton.layer.shadowOpacity = 0.0;
        self.extensionButton.layer.shadowOpacity = 1.0;
    }
}

- (void)switchTypeWithButton:(UIButton *)button
{
    if ([button isEqual:self.normalButton]) {
        self.type = XDebugSwitchViewTypeNormal;
    }else
    {
        self.type = XDebugSwitchViewTypeExtension;
    }
    
    if (self.didSwitchType) {
        self.didSwitchType(self, self.type);
    }
}

@end
