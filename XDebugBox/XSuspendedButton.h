//
//  XSuspendedButton.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kXSuspendedButtonKey = @"XSuspendedButtonKey";

@class XSuspendedButton;

@protocol XSuspendedButtonDelegate <NSObject>

@optional

-(void)suspendedButtonClick:(XSuspendedButton *)suspendedButton;

-(void)suspendedButtonTouchBegin:(XSuspendedButton *)suspendedButton;

-(void)suspendedButtonTouchMove:(XSuspendedButton *)suspendedButton;

-(void)suspendedButtonTouchEnd:(XSuspendedButton *)suspendedButton;

@end

typedef NS_ENUM(NSUInteger, XSuspendedButtonStayType) {
    XSuspendedButtonStayTypeHorizontal,
    XSuspendedButtonStayTypeEachSide,
    XSuspendedButtonStayTypeAnyWhere
};

@interface XSuspendedButton : UIButton

@property(nonatomic, weak) id <XSuspendedButtonDelegate> delegate;

@property(nonatomic, assign) NSUInteger stayType;

+ (instancetype) suspendedButtonWithDelegate:(id<XSuspendedButtonDelegate>)delegate;

-(void) show;

-(void) removeFromScreen;

@end
