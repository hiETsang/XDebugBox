//
//  XDebugBoxManager.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDebugBoxManager : NSObject

+ (instancetype)shared;

+ (void)openDebugBox;

@property(nonatomic, strong) NSArray *extensionArray;

@property(nonatomic, strong) NSArray *normalArray;

@end
