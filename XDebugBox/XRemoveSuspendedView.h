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

- (void)showWithAnimation;

- (void)hideWithAnimation;

- (void)removeFromScreen;

@end
