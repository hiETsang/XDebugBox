//
//  XDebugBoxManager.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/28.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDebugBoxManager : NSObject

+ (instancetype)shared;

+ (void)openDebugBox;


/**
 扩展工具数组
 */
@property(nonatomic, strong) NSArray *extensionArray;

/**
 通用工具数组
 */
@property(nonatomic, strong) NSArray *normalArray;

@end
