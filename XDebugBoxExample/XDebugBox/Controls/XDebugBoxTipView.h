//
//  XDebugBoxTipView.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/5.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDebugBoxTipView : UIView

+ (XDebugBoxTipView *)showTip:(NSString *)tip;

+ (XDebugBoxTipView *)showTip:(NSString *)tip duration:(NSTimeInterval)duration;

@end
