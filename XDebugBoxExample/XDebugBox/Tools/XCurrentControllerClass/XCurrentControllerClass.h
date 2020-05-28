//
//  XCurrentControllerClass.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/8.
//  Copyright © 2019 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XCurrentControllerClass : NSObject

/**
 获取当前显示的VC

 @return 当前正在显示的ViewController
 */
+ (UIViewController*)currentViewController;


/**
 获取当前显示的VC数组
 
 @return 当前正在显示的VC以及它的子VC,如果没有子vc，返回当前vc字符串，如果有，返回包含子vc的字典
 */
+ (id)currentViewControllerAndSubViewControllers;

@end
