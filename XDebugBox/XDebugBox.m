//
//  XDebugBox.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugBox.h"
#import "XDebugBoxManager.h"

@implementation XDebugBox

+ (void)open
{
#if DEBUG
    [XDebugBoxManager openDebugBox];
#endif
}

+ (void)configActionArray:(NSArray<XDebugDataModel *> *)array
{
#if DEBUG
    [XDebugBoxManager shared].extensionArray = array;
#endif
}

@end
