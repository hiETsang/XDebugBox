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

#define kXAnimationKey @"XAnimationKey"
#define kXShowAnimation @"XShowAnimation"
#define kXHideAnimation @"XHideAnimation"
#define kXRemoveSuspendedViewWidth 160

@interface XRemoveSuspendedView ()<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *backLayer;
@property(nonatomic, strong) CALayer *trashLayer;

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
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)) radius:CGRectGetWidth(self.frame) - 15 startAngle:M_PI endAngle:1.5 * M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
    
    self.backLayer = [CAShapeLayer layer];
    self.backLayer.frame = CGRectMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
    self.backLayer.path = path.CGPath;
    self.backLayer.fillColor = [UIColor colorWithRed:235/255.0 green:82/255.0 blue:82/255.0 alpha:1.0].CGColor;
    self.backLayer.strokeColor = [UIColor colorWithRed:235/255.0 green:82/255.0 blue:82/255.0 alpha:1.0].CGColor;
    self.backLayer.lineWidth = 0;

    [self.layer addSublayer:self.backLayer];
    
    CALayer *trashLayer = [CALayer layer];
    trashLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"delete_close"].CGImage);
    trashLayer.contentsGravity = kCAGravityResizeAspect;
    trashLayer.frame = CGRectMake(kXRemoveSuspendedViewWidth - 70, kXRemoveSuspendedViewWidth - 80, 30, 42);
    [self.backLayer addSublayer:trashLayer];
    self.trashLayer = trashLayer;
}

- (UIWindow *)configWindow
{
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    XDebugContainerWindow *window = [[XDebugContainerWindow alloc] initWithFrame:self.frame];
    window.windowLevel = window.windowLevel - 1;
    window.rootViewController = [[UIViewController alloc] init];
    [window makeKeyAndVisible];
    [currentWindow makeKeyWindow];
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
    [window addSubview:self];
    window.hidden = YES;
    
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
    
    //动画之前就将layer的位置移动过去
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.backLayer.position = self.center;
    
    [CATransaction commit];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.duration = .3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame) + CGRectGetWidth(self.frame)/2.0, CGRectGetWidth(self.frame) + CGRectGetWidth(self.frame)/2.0)];
    animation.toValue = [NSValue valueWithCGPoint:self.center];
    [animation setValue:kXShowAnimation forKey:kXAnimationKey];
    [self.backLayer addAnimation:animation forKey:nil];
}

- (void)hideWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXRemoveSuspendedViewKey];
    if (!window) {
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.backLayer.position = CGPointMake(CGRectGetWidth(self.frame) + CGRectGetWidth(self.frame)/2.0, CGRectGetWidth(self.frame) + CGRectGetWidth(self.frame)/2.0);
    [CATransaction commit];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = .3;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSValue valueWithCGPoint:self.center];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame) + CGRectGetWidth(self.frame)/2.0, CGRectGetWidth(self.frame) + CGRectGetWidth(self.frame)/2.0)];
    [animation setValue:kXHideAnimation forKey:kXAnimationKey];
    [self.backLayer addAnimation:animation forKey:nil];
}

- (void)removeFromScreen
{
    [XDebugWindowManager removeWindowForKey:kXRemoveSuspendedViewKey];
}

- (void)layerAmplification
{
    if (self.backLayer.lineWidth != 30) {
        self.backLayer.lineWidth = 30;
        self.trashLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"delete"].CGImage);
    }
}

- (void)layerNarrow
{
    if (self.backLayer.lineWidth != 0) {
        self.backLayer.lineWidth = 0;
        self.trashLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"delete_close"].CGImage);
    }
}

#pragma mark - animationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *value = [anim valueForKey:kXAnimationKey];
    if([value isEqualToString:kXHideAnimation])
    {
        [[XDebugWindowManager windowForkey:kXRemoveSuspendedViewKey] setHidden:YES];
        
        if (self.didEndHideAnimation) {
            self.didEndHideAnimation(self);
        }
    }
}


@end
