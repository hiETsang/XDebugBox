//
//  XDebugViewController.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDebugViewController : UIViewController

+ (instancetype)debugViewController;

- (void)showWithAnimation;

- (void)removeWithAnimation;

/** 点击其他区域缩小调试窗 */
@property (nonatomic,copy) void (^tapWindow)(XDebugViewController *debugViewController);

@end
