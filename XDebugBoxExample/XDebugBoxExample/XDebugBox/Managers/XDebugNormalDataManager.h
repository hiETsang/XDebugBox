//
//  XDebugNormalDataManager.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/2.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDebugNormalDataManager : NSObject

+ (instancetype)shared;

+ (void)sharedDelloc;

/**
 获取通用数组

 @return 从沙盒中获取，如果不存在则重新创建默认的数组
 */
+ (NSArray *)arrayFormSandBox;


/**
 删除沙盒中缓存的数组

 @return 是否成功
 */
- (BOOL)deletePlistInSandBoxLibraryCaches;

@end
