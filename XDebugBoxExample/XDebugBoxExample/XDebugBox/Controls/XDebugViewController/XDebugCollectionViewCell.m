//
//  XDebugCollectionViewCell.m
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/29.
//  Copyright © 2019年 canoe. All rights reserved.
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
    
    UIView *mainView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:mainView];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 14;
    mainView.layer.shadowColor = RGBA(0, 0, 0, 0.1).CGColor;
    mainView.layer.shadowOffset = CGSizeMake(0, 3);
    mainView.layer.shadowRadius = 8;
    mainView.layer.shadowOpacity = 1.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:mainView.bounds];
    mainView.layer.shadowPath = path.CGPath;
    self.mainView = mainView;
    
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

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        //选中时
        self.mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else{
        //非选中
        self.mainView.backgroundColor = [UIColor whiteColor];
    }
}

@end
