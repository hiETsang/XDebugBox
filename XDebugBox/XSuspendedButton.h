//
//  XSuspendedButton.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kXSuspendedButtonKey = @"kXSuspendedButtonKey";

@class XSuspendedButton;
@protocol XSuspendedButtonDelegate <NSObject>

-(void)suspendedButtonClick:(XSuspendedButton *)suspendedButton;

@end

typedef NS_ENUM(NSUInteger, XSuspendedButtonStayType) {
    XSuspendedButtonStayTypeHorizontal,
    XSuspendedButtonStayTypeEachSide,
    XSuspendedButtonStayTypeAnyWhere
};

@interface XSuspendedButton : UIButton

@property(nonatomic, weak) id <XSuspendedButtonDelegate> delegate;

@property(nonatomic, assign) NSUInteger stayType;

-(void) show;

-(void) hide;

-(void) removeFromScreen;

@end
