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
    self.normalButton.clipsToBounds = YES;
    self.normalButton.layer.cornerRadius = kRatioHeight(13.5);
    [self.normalButton setTitle:@"通用" forState:UIControlStateNormal];
    [self.normalButton setTitleColor:RGBA(115, 149, 247, 1) forState:UIControlStateSelected];
    [self.normalButton setTitleColor:RGBA(180, 182, 189, 1) forState:UIControlStateNormal];
    self.normalButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    
    UIView *normalShadowView = [[UIView alloc] initWithFrame:self.normalButton.frame];
    [self addSubview:normalShadowView];
    normalShadowView.backgroundColor = [UIColor clearColor];
    normalShadowView.layer.shadowColor = RGBA(47, 53, 62, 0.08).CGColor;
    normalShadowView.layer.shadowOffset = CGSizeMake(0, 4);
    normalShadowView.layer.shadowRadius = 8;
    normalShadowView.layer.shadowOpacity = 1.0;
    self.normalButton.frame = normalShadowView.bounds;
    [normalShadowView addSubview:self.normalButton];
    
    self.extensionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.extensionButton.frame = CGRectMake(kRatioWidth(179), kRatioHeight(12), kRatioWidth(102), kRatioHeight(27));
    self.extensionButton.backgroundColor = [UIColor whiteColor];
    self.extensionButton.clipsToBounds = YES;
    self.extensionButton.layer.cornerRadius = kRatioHeight(13.5);
    [self.extensionButton setTitle:@"扩展" forState:UIControlStateNormal];
    [self.extensionButton setTitleColor:RGBA(115, 149, 247, 1) forState:UIControlStateSelected];
    [self.extensionButton setTitleColor:RGBA(180, 182, 189, 1) forState:UIControlStateNormal];
    self.extensionButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    
    UIView *extensionShadowView = [[UIView alloc] initWithFrame:self.extensionButton.frame];
    [self addSubview:extensionShadowView];
    extensionShadowView.backgroundColor = [UIColor clearColor];
    extensionShadowView.layer.shadowColor = RGBA(47, 53, 62, 0.08).CGColor;
    extensionShadowView.layer.shadowOffset = CGSizeMake(0, 4);
    extensionShadowView.layer.shadowRadius = 8;
    extensionShadowView.layer.shadowOpacity = 1.0;
    self.extensionButton.frame = extensionShadowView.bounds;
    [extensionShadowView addSubview:self.extensionButton];
    
    self.normalButton.selected = YES;
}

@end
