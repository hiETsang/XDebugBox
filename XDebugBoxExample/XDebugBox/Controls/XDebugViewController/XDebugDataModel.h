//
//  XDebugDataModel.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/29.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XDebugDataModel : NSObject

@property(nonatomic, copy) NSString *titleStr;
@property(nonatomic, copy) NSString *detailStr;
@property(nonatomic, assign) BOOL autoClose;
@property(nonatomic, copy) NSString *methodName;
@property(nonatomic, copy) void (^action)(UIViewController *debugController);

+ (instancetype)debugModelWithTitle:(NSString *)title
                             detail:(NSString *)detail
                          autoClose:(BOOL)autoClose
                             action:(void (^)(UIViewController *debugController))action;


@end
