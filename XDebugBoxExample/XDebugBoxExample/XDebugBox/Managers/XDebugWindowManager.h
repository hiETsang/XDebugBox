//
//  XDebugWindowManager.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/25.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XDebugWindowManager : NSObject

+ (instancetype)shared;

+ (void)sharedDelloc;

+ (UIWindow *)windowForkey:(NSString *)key;

+ (void)saveWindow:(UIWindow *)window ForKey:(NSString *)key;

+ (void)removeWindowForKey:(NSString *)key;

+ (void)removeAllWindow;

@end
