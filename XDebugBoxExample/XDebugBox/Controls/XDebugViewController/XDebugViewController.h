//
//  XDebugViewController.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/25.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kNormalActionNotification;
extern NSString * const kNormalActionDictKey;
extern NSString * const kXDebugViewController;

@interface XDebugViewController : UIViewController

+ (instancetype)debugViewController;

- (void)showWithAnimation;

- (void)removeWithAnimation;

/** 点击其他区域缩小调试窗 */
@property (nonatomic,copy) void (^tapWindow)(XDebugViewController *debugViewController);

@end
