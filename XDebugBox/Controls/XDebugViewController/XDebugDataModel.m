//
//  XDebugDataModel.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugDataModel.h"

@implementation XDebugDataModel

+(instancetype)debugModelWithTitle:(NSString *)title detail:(NSString *)detail autoClose:(BOOL)autoClose action:(void (^)(XDebugViewController *debugViewController))action
{
    XDebugDataModel *model = [[XDebugDataModel alloc] init];
    model.titleStr = title;
    model.detailStr = detail;
    model.autoClose = autoClose;
    model.action = action;
    return model;
}

-(NSString *)titleStr
{
    if (_titleStr == nil) {
        _titleStr = @"未命名调试模块";
    }
    return _titleStr;
}

@end
