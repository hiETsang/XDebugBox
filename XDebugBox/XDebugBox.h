//
//  XDebugBox.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDebugDataModel.h"

@interface XDebugBox : NSObject


/**
 显示小圆点
 */
+ (void)open;


/**
 设置自定义扩展工具

 @param array XDebugDataModel类型的数组
 */
+ (void)configActionArray:(NSArray <XDebugDataModel *>*)array;

@end
