//
//  XDebugSwitchView.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XDebugSwitchViewType) {
    XDebugSwitchViewTypeNormal,
    XDebugSwitchViewTypeExtension
};

@interface XDebugSwitchView : UIView

@property(nonatomic, assign) XDebugSwitchViewType type;

@end
