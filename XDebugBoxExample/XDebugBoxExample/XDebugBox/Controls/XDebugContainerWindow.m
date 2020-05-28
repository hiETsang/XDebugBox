//
//  XDebugContainerWindow.m
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/25.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import "XDebugContainerWindow.h"

@implementation XDebugContainerWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelAlert + 1000000.00;
    }
    return self;
}


@end
