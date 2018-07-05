//
//  XDebugBoxTipView.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/5.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugBoxTipView.h"
#import "XMacros.h"
#import "XDebugWindowManager.h"
#import "XDebugViewController.h"

@implementation XDebugBoxTipView

+ (XDebugBoxTipView *)showTip:(NSString *)tip
{
    return [XDebugBoxTipView showTip:tip duration:1.5];
}

+ (XDebugBoxTipView *)showTip:(NSString *)tip duration:(NSTimeInterval)duration
{
    if (tip.length == 0 || ![XDebugWindowManager windowForkey:kXDebugViewController]) {
        return nil;
    }
    
    XDebugBoxTipView *tipView = [[XDebugBoxTipView alloc] init];
    [[XDebugWindowManager windowForkey:kXDebugViewController] addSubview:tipView];
    tipView.backgroundColor = RGB(255, 83, 77);
    tipView.alpha = 0.0;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kRatioWidth(200), 0)];
    [tipView addSubview:tipLabel];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont boldSystemFontOfSize:13];
    tipLabel.text = tip;
    tipLabel.numberOfLines = 0;
    [tipLabel sizeToFit];

    
    tipView.frame = CGRectMake(0, 0, tipLabel.frame.size.width + kRatioWidth(40), tipLabel.frame.size.height + kRatioHeight(10));
    tipView.center = CGPointMake(KScreenWidth/2, KScreenHeight - kRatioHeight(167 * 0.5 + 40));
    tipLabel.frame = tipView.bounds;
    tipView.layer.cornerRadius = tipView.frame.size.height/2.0;
    tipView.layer.shadowColor = RGBA(0, 0, 0, 0.2).CGColor;
    tipView.layer.shadowOffset = CGSizeMake(0, 2);
    tipView.layer.shadowRadius = 8;
    tipView.layer.shadowOpacity = 1.0;
    UIBezierPath *extensionPath = [UIBezierPath bezierPathWithRect:tipView.bounds];
    tipView.layer.shadowPath = extensionPath.CGPath;
    
    [UIView animateWithDuration:0.5 animations:^{
        tipView.center = CGPointMake(KScreenWidth/2, KScreenHeight - kRatioHeight(167 * 0.5 + 50));
        tipView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{
            tipView.center = CGPointMake(KScreenWidth/2, KScreenHeight - kRatioHeight(167 * 0.5 + 40));
            tipView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [tipView removeFromSuperview];
        }];
    }];
    
    return tipView;
}

@end
