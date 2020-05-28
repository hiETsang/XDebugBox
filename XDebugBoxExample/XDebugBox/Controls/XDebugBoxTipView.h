//
//  XDebugBoxTipView.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/5.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDebugBoxTipView : UIView

+ (XDebugBoxTipView *)showTip:(NSString *)tip;

+ (XDebugBoxTipView *)showTip:(NSString *)tip duration:(NSTimeInterval)duration;

@end
