//
//  XClearCache.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/5.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XClearCache : NSObject

+ (NSString *)getCacheSize;

+ (BOOL)cleanAppCache;

@end
