//
//  XDebugBoxManager.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/28.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugBoxManager.h"
#import "XDebugWindowManager.h"
#import "XDebugNormalDataManager.h"

#import "XRemoveSuspendedView.h"
#import "XDebugViewController.h"
#import "XSuspendedButton.h"

static XDebugBoxManager * _instance;

@interface XDebugBoxManager ()<XSuspendedButtonDelegate>

@property(nonatomic, strong) XSuspendedButton *suspendedButton;
@property(nonatomic, strong) XRemoveSuspendedView *suspendedView;
@property(nonatomic, strong) XDebugViewController *debugController;

@end

@implementation XDebugBoxManager

+ (instancetype)shared
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark - lazyLoad

-(NSArray *)extensionArray
{
    if (!_extensionArray) {
        _extensionArray = [NSArray array];
    }
    return _extensionArray;
}

- (NSArray *)normalArray
{
    return [XDebugNormalDataManager arrayFormSandBox];
}

#pragma mark - configDebugBox

+ (void)openDebugBox
{
#if DEBUG
    [[XDebugBoxManager shared] configDebugBox];
#endif
}

- (void)configDebugBox
{
    self.suspendedButton = [XSuspendedButton suspendedButtonWithDelegate:self];
    self.suspendedView = [XRemoveSuspendedView suspendedView];
    self.debugController = [XDebugViewController debugViewController];
    
    [self.suspendedButton show];
    
    [self.debugController setTapWindow:^(XDebugViewController *debugViewController) {
        [debugViewController removeWithAnimation];
        [XDebugWindowManager windowForkey:kXSuspendedButtonKey].hidden = NO;
    }];
    [self.suspendedView setDidEndHideAnimation:^(XRemoveSuspendedView *suspendedView) {
        [[XDebugBoxManager shared] removeDebugBox];
    }];
}

- (void)removeDebugBox
{
    if (![XDebugWindowManager windowForkey:kXSuspendedButtonKey]) {
        [XDebugWindowManager removeAllWindow];
        self.suspendedView = nil;
        self.suspendedButton = nil;
        self.debugController = nil;
        self.normalArray = nil;
        self.extensionArray = nil;
    }
}

#pragma mark - suspendedButtonDelegate

- (void)suspendedButtonClick:(XSuspendedButton *)suspendedButton
{
    [XDebugWindowManager windowForkey:kXSuspendedButtonKey].hidden = YES;
    [self.debugController showWithAnimation];
}

-(void)suspendedButtonTouchBegin:(XSuspendedButton *)suspendedButton
{
    [self.suspendedView showWithAnimation];
}

-(void)suspendedButtonTouchMove:(XSuspendedButton *)suspendedButton
{
    if ([self removeSuspendedViewIsContainSuspendedButton:suspendedButton]) {
        [self.suspendedView layerAmplification];
    }else
    {
        [self.suspendedView layerNarrow];
    }
}

-(void)suspendedButtonTouchEnd:(XSuspendedButton *)suspendedButton
{
    if ([self removeSuspendedViewIsContainSuspendedButton:suspendedButton]) {
        [suspendedButton removeFromScreen];
    }
    [self.suspendedView hideWithAnimation];
}

- (BOOL)removeSuspendedViewIsContainSuspendedButton:(XSuspendedButton *)suspendedButton
{
    CGPoint buttonCenter = [suspendedButton convertPoint:suspendedButton.center toView:UIApplication.sharedApplication.keyWindow];
    
    CGPoint suspendedCircleCenter = [self.suspendedView convertPoint:CGPointMake(CGRectGetMaxX(self.suspendedView.frame), CGRectGetMaxY(self.suspendedView.frame)) toView:UIApplication.sharedApplication.keyWindow];
    
    CGFloat buttonRadius = CGRectGetWidth(suspendedButton.frame) / 2.0;
    CGFloat suspendedCircleRadius = CGRectGetWidth(self.suspendedView.frame);
    
    CGFloat distance = sqrt(pow((suspendedCircleCenter.x - buttonCenter.x), 2) + pow((suspendedCircleCenter.y - buttonCenter.y), 2));
    
    return distance <= (suspendedCircleRadius - buttonRadius);
}

@end
