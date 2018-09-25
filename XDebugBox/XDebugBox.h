//
//  XDebugBox.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XDebugDataModel;
@interface XDebugBox : NSObject

+ (void)open;

+ (void)configActionArray:(NSArray <XDebugDataModel *>*)array;

@end
