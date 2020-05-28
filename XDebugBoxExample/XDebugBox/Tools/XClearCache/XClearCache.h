//
//  XClearCache.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/5.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XClearCache : NSObject

+ (NSString *)getCacheSize;

+ (BOOL)cleanAppCache;

@end
