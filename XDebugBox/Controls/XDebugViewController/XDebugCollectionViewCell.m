//
//  XDebugCollectionViewCell.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugCollectionViewCell.h"
#import "XMacros.h"

@interface XDebugCollectionViewCell ()

@end

@implementation XDebugCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIView *backShadowView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:backShadowView];
    backShadowView.backgroundColor = [UIColor clearColor];
    backShadowView.layer.shadowColor = RGBA(0, 0, 0, 0.1).CGColor;
    backShadowView.layer.shadowOffset = CGSizeMake(0, 3);
    backShadowView.layer.shadowRadius = 8;
    backShadowView.layer.shadowOpacity = 1.0;
    
    UIView *mainView = [[UIView alloc] initWithFrame:backShadowView.bounds];
    [backShadowView addSubview:mainView];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.clipsToBounds = YES;
    mainView.layer.cornerRadius = 14;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRatioWidth(12), kRatioHeight(8), kRatioWidth(106), 20)];
    [mainView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    self.titleLabel.textColor = RGBA(74, 74, 74, 1);
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRatioWidth(12), 20 + kRatioHeight(13), kRatioWidth(106), 28)];
    [mainView addSubview:self.descLabel];
    self.descLabel.numberOfLines = 2;
    self.descLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:10];
    self.descLabel.textColor = RGBA(155, 155, 155, 1);
}

@end
