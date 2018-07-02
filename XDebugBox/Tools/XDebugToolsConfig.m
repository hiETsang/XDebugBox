//
//  XDebugToolsConfig.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/2.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugToolsConfig.h"
#import "XDebugDataModel.h"

NSString *const kNormalTitle = @"titleStr";
NSString *const kNormalDetail = @"detailStr";
NSString *const kNormalAutoClose = @"autoClose";
NSString *const kNormalMethodName = @"methodName";

@implementation XDebugToolsConfig

-(NSArray *)array
{
    if (!_array) {
        _array = [NSArray arrayWithObjects:
                  @{kNormalTitle:@"测试",
                    kNormalDetail:@"详情",
                    kNormalAutoClose:@(0),
                    kNormalMethodName:@"test1"
                    },
                  @{kNormalTitle:@"测试2",
                    kNormalDetail:@"detail",
                    kNormalAutoClose:@(0),
                    kNormalMethodName:@"test2"
                    },
                  nil];
    }
    return _array;
}

- (NSArray *)debugModelWithDictArray:(NSArray *)array
{
    return array;
    XDebugDataModel *model = [[XDebugDataModel alloc] init];
}

@end
