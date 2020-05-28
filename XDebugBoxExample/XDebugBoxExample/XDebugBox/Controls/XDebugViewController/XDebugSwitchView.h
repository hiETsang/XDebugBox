//
//  XDebugSwitchView.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/29.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XDebugSwitchViewType) {
    XDebugSwitchViewTypeNormal,
    XDebugSwitchViewTypeExtension
};

@interface XDebugSwitchView : UIView

@property(nonatomic, assign) XDebugSwitchViewType type;

/** 切换显示状态 */
@property (nonatomic,copy) void (^didSwitchType)(XDebugSwitchView *switchView,XDebugSwitchViewType type);

@end
