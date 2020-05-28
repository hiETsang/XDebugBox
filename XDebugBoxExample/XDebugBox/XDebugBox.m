//
//  XDebugBox.m
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/28.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import "XDebugBox.h"
#import "XDebugBoxManager.h"
#import "XDebugBoxTipView.h"

@implementation XDebugBox

+ (void)open
{
    [XDebugBoxManager openDebugBox];
}

+ (void)configActionArray:(NSArray<XDebugDataModel *> *)array
{
    [XDebugBoxManager shared].extensionArray = array;
}

+ (void)showTip:(NSString *)tip
{
    [XDebugBoxTipView showTip:tip];
}

@end
