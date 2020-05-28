//
//  XDebugToolsConfig.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/2.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDebugToolsConfig : NSObject

/**
 默认通用数组
 */
@property(nonatomic, strong) NSArray *array;

/**
 将从沙盒中取出的字典数组转成debug模型数组
 */
- (NSArray *)debugModelArrayWithDictArray:(NSArray *)array;

@end
