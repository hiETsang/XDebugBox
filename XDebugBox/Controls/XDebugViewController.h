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

@end
