//
//  XSuspendedButton.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XSuspendedButton.h"
#import "XDebugWindowManager.h"
#import "XDebugContainerWindow.h"
#import "XSuspendedButtonController.h"
#import "XMacros.h"

#define kSuspendedButtonWidth 65.0
#define kStayProportion (8/kSuspendedButtonWidth)
#define kVerticalMargin 20.0
#define kButtonAlpha 0.3

@implementation XSuspendedButton

+ (instancetype) suspendedButtonWithDelegate:(id<XSuspendedButtonDelegate>)delegate
{
    return [[self alloc] initWithFrame:CGRectMake(-kStayProportion * kSuspendedButtonWidth, 300, kSuspendedButtonWidth, kSuspendedButtonWidth) delegate:delegate];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame delegate:nil];
}

-(instancetype)initWithFrame:(CGRect)frame delegate:(id<XSuspendedButtonDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.layer.allowsGroupOpacity = NO;
        self.alpha = kButtonAlpha;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
        self.layer.borderWidth = 8;
        self.layer.cornerRadius = kSuspendedButtonWidth/2.0;
        [self setImage:[UIImage imageNamed:kXDebugBoxSrcName(@"mainIcon")?:kXDebugBoxFrameworkSrcName(@"mainIcon")] forState:UIControlStateNormal];
        self.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


#pragma mark - public

- (void)removeFromScreen
{
    [XDebugWindowManager removeWindowForKey:kXSuspendedButtonKey];
}

- (void)show
{
    if ([XDebugWindowManager windowForkey:kXSuspendedButtonKey]) {
        return;
    }
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    XDebugContainerWindow *window = [[XDebugContainerWindow alloc] initWithFrame:self.frame];
    window.rootViewController = [[XSuspendedButtonController alloc] init];
    [window makeKeyAndVisible];
    [currentWindow makeKeyWindow];
    
    self.frame = CGRectMake(0, 0, kSuspendedButtonWidth, kSuspendedButtonWidth);
    [window addSubview:self];
    
    [XDebugWindowManager saveWindow:window ForKey:kXSuspendedButtonKey];
}

#pragma mark - event

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint point = [pan locationInView:appWindow];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(suspendedButtonTouchBegin:)]) {
            [self.delegate suspendedButtonTouchBegin:self];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1;
        }];
    }else if(pan.state == UIGestureRecognizerStateChanged)
    {
        if ([self.delegate respondsToSelector:@selector(suspendedButtonTouchMove:)]) {
            [self.delegate suspendedButtonTouchMove:self];
        }
        
        [XDebugWindowManager windowForkey:kXSuspendedButtonKey].center = point;
    }else if(pan.state == UIGestureRecognizerStateEnded)
    {
        if ([self.delegate respondsToSelector:@selector(suspendedButtonTouchEnd:)]) {
            [self.delegate suspendedButtonTouchEnd:self];
        }
        
        if (self.stayType == XSuspendedButtonStayTypeAnyWhere) {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = kButtonAlpha;
                [XDebugWindowManager windowForkey:kXSuspendedButtonKey].center = point;
            }];
            return;
        }
        
        CGFloat ballWidth = self.frame.size.width;
        CGFloat ballHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat left = fabs(point.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(point.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = 0;
        if (self.stayType == XSuspendedButtonStayTypeHorizontal) {
            minSpace = MIN(left, right);
        }else{
            minSpace = MIN(MIN(MIN(top, left), bottom), right);
        }
        CGPoint newCenter = CGPointZero;
        CGFloat targetY = 0;
        
        //Correcting Y
        if (point.y < kVerticalMargin + ballHeight / 2.0) {
            targetY = kVerticalMargin + ballHeight / 2.0;
        }else if (point.y > (screenHeight - ballHeight / 2.0 - kVerticalMargin)) {
            targetY = screenHeight - ballHeight / 2.0 - kVerticalMargin;
        }else{
            targetY = point.y;
        }
        
        CGFloat centerXSpace = (0.5 - kStayProportion) * ballWidth;
        CGFloat centerYSpace = (0.5 - kStayProportion) * ballHeight;
        
        if (minSpace == left) {
            newCenter = CGPointMake(centerXSpace, targetY);
        }else if (minSpace == right) {
            newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
        }else if (minSpace == top) {
            newCenter = CGPointMake(point.x, centerYSpace);
        }else {
            newCenter = CGPointMake(point.x, screenHeight - centerYSpace);
        }
        
        [UIView animateWithDuration:.25 animations:^{
            self.alpha = kButtonAlpha;
            [XDebugWindowManager windowForkey:kXSuspendedButtonKey].center = newCenter;
        }];
    }
}

- (void)click
{
    if ([self.delegate respondsToSelector:@selector(suspendedButtonClick:)]) {
        [self.delegate suspendedButtonClick:self];
    }
}



@end
