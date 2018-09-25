//
//  XDebugDataModel.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDebugViewController.h"

@interface XDebugDataModel : NSObject

@property(nonatomic, copy) NSString *titleStr;
@property(nonatomic, copy) NSString *detailStr;
@property(nonatomic, assign) BOOL autoClose;
@property(nonatomic, copy) void (^action)(XDebugViewController *debugViewController);

+ (instancetype)debugModelWithTitle:(NSString *)title detail:(NSString *)detail autoClose:(BOOL)autoClose action:(void (^)(XDebugViewController *debugViewController))action;


@end
