//
//  XRemoveSuspendedView.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XRemoveSuspendedView.h"
#import "XDebugWindowManager.h"
#import "XDebugContainerWindow.h"

#define kXRemoveSuspendedViewWidth 160

@interface XRemoveSuspendedView ()<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *backLayer;

@end

@implementation XRemoveSuspendedView

+ (instancetype)suspendedView
{
    return [[self alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - kXRemoveSuspendedViewWidth, [UIScreen mainScreen].bounds.size.height - kXRemoveSuspendedViewWidth, kXRemoveSuspendedViewWidth, kXRemoveSuspendedViewWidth)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configLayer];
    }
    return self;
}

- (void)configLayer
{
    self.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)) radius:CGRectGetWidth(self.frame) - 10 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    self.backLayer = [CAShapeLayer layer];
    self.backLayer.frame = CGRectMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
    self.backLayer.path = path.CGPath;
    self.backLayer.fillColor = [UIColor redColor].CGColor;
    self.backLayer.strokeColor = [UIColor redColor].CGColor;

    [self.layer addSublayer:self.backLayer];
}

- (UIWindow *)configWindow
{
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    XDebugContainerWindow *window = [[XDebugContainerWindow alloc] initWithFrame:self.frame];
    window.windowLevel = window.windowLevel - 1;
    window.rootViewController = [[UIViewController alloc] init];
    [window makeKeyAndVisible];
    [currentWindow makeKeyWindow];
    window.hidden = YES;
    
    self.frame = CGRectMake(0, 0, kXRemoveSuspendedViewWidth, kXRemoveSuspendedViewWidth);
    [window addSubview:self];
    
    [XDebugWindowManager saveWindow:window ForKey:kXRemoveSuspendedViewKey];
    
    return window;
}

#pragma mark - public

- (void)showWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXRemoveSuspendedViewKey];
    if (!window) {
        window = [self configWindow];
    }
    
    window.hidden = NO;
    self.backLayer.frame = self.bounds;
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"frame"];
//    animation.duration = 1.5;
//    animation.toValue = [NSValue valueWithCGRect:self.bounds];
//    [self.backLayer addAnimation:animation forKey:nil];
}

- (void)hideWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXRemoveSuspendedViewKey];
    if (!window) {
        window = [self configWindow];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"frame"];
    animation.duration = 1.5;
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
    [self.backLayer addAnimation:animation forKey:nil];
    
}

- (void)removeFromScreen
{
    [XDebugWindowManager removeWindowForKey:kXRemoveSuspendedViewKey];
}

#pragma mark - animationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[XDebugWindowManager windowForkey:kXRemoveSuspendedViewKey] setHidden:YES];
}


@end
