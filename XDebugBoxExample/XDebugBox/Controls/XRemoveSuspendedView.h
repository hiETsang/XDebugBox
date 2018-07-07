//
//  XRemoveSuspendedView.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kXRemoveSuspendedViewKey = @"XRemoveSuspendedViewKey";

@interface XRemoveSuspendedView : UIView

+ (instancetype)suspendedView;

/**
 从右下角动画显示出来
 */
- (void)showWithAnimation;

/**
 缩回右下角并隐藏
 */
- (void)hideWithAnimation;

/**
 圆点进入当前区域，layer显示范围扩大
 */
- (void)layerAmplification;

/**
 圆点离开当前区域，layer显示范围缩小
 */
- (void)layerNarrow;

/**
 window彻底销毁
 */
- (void)removeFromScreen;

/** 动画结束回调 */
@property (nonatomic,copy) void (^didEndHideAnimation)(XRemoveSuspendedView *suspendedView);
- (void)setDidEndHideAnimation:(void (^)(XRemoveSuspendedView *suspendedView))didEndHideAnimation;

@end
