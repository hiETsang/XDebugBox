//
//  XDebugWindowManager.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugWindowManager.h"

static XDebugWindowManager * _instance;

static dispatch_once_t onceToken;

@interface XDebugWindowManager ()

@property(nonatomic, strong) NSMutableDictionary *windowsDict;

@end

@implementation XDebugWindowManager

+ (instancetype)shared
{
    if (!_instance) {
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

- (NSMutableDictionary *)windowsDict
{
    if (!_windowsDict) {
        _windowsDict = [NSMutableDictionary dictionary];
    }
    return _windowsDict;
}

+ (void)sharedDelloc
{
    onceToken = 0;
    _instance = nil;
}

#pragma mark - public method

+ (UIWindow *)windowForkey:(NSString *)key
{
    return [[XDebugWindowManager shared].windowsDict objectForKey:key];
}

+ (void)saveWindow:(UIWindow *)window ForKey:(NSString *)key
{
    [[XDebugWindowManager shared].windowsDict setObject:window forKey:key];
}

+ (void)removeWindowForKey:(NSString *)key
{
    UIWindow *window = [[XDebugWindowManager shared].windowsDict objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    window.rootViewController = nil;
    [[XDebugWindowManager shared].windowsDict removeObjectForKey:key];
}

+ (void)removeAllWindow
{
    for (UIWindow *window in [XDebugWindowManager shared].windowsDict.allValues) {
        if (window.rootViewController.presentedViewController) {
            [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        }
        window.hidden = YES;
        window.rootViewController = nil;
    }
    [[XDebugWindowManager shared].windowsDict removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
