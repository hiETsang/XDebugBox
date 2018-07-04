//
//  XDebugToolsConfig.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/2.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugToolsConfig.h"
#import "XDebugDataModel.h"
#import "XDebugViewController.h"
#import "XMacros.h"

#import "XDebugNormalDataManager.h"
#import "XDebugBoxManager.h"
#import "XAnimationSpeedController.h"

NSString *const kNormalTitle = @"titleStr";
NSString *const kNormalDetail = @"detailStr";
NSString *const kNormalAutoClose = @"autoClose";
NSString *const kNormalMethodName = @"methodName";

@implementation XDebugToolsConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:kNormalActionNotification object:nil];
    }
    return self;
}

- (void)receiveNotification:(NSNotification *)notification {
    XDebugDataModel *model = (XDebugDataModel *)notification.object;
    XDebugViewController *viewController = (XDebugViewController *)notification.userInfo[kNormalActionDictKey];
    if ([self respondsToSelector:NSSelectorFromString(model.methodName)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(model.methodName) withObject:viewController];
#pragma clang diagnostic pop
    }
}

#pragma mark - public

-(NSArray *)array
{
    _array = [NSArray arrayWithObjects:
              @{kNormalTitle:@"调整全局动画速度",
                kNormalDetail:@"方便查看动画效果",
                kNormalAutoClose:@(0),
                kNormalMethodName:@"changeAnimationSpeed:"
                },
              @{kNormalTitle:@"网络请求显示",
                kNormalDetail:@"显示上一次网络请求的信息",
                kNormalAutoClose:@(0),
                kNormalMethodName:@"test2:"
                },
              @{kNormalTitle:@"缓存清理",
                kNormalDetail:@"清理沙盒路径中的缓存文件",
                kNormalAutoClose:@(0),
                kNormalMethodName:@"test2:"
                },
              @{kNormalTitle:@"刷新通用工具列表",
                kNormalDetail:@"清理本地的plist，重新加载通用方法数组",
                kNormalAutoClose:@(0),
                kNormalMethodName:@"reloadNormalList:"
                },
              nil];
    return _array;
}

- (NSArray *)debugModelArrayWithDictArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        XDebugDataModel *model = [[XDebugDataModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [arrayM addObject:model];
    }
    return [NSArray arrayWithArray:arrayM];
}

#pragma mark - normalActions

-(void)changeAnimationSpeed:(XDebugViewController *)viewController
{
    XAnimationSpeedController *vc = [[XAnimationSpeedController alloc] init];
    vc.title = @"调整全局动画速度";
    [viewController.navigationController pushViewController:vc animated:YES];
    NSLog(@"test1");
}

- (void)test2:(XDebugViewController *)viewController
{
    NSLog(@"test2");
}

//刷新通用方法列表
- (void)reloadNormalList:(XDebugViewController *)viewController
{
    [[XDebugNormalDataManager shared] deletePlistInSandBoxLibraryCaches];
    [XDebugBoxManager shared].normalArray = [XDebugNormalDataManager arrayFormSandBox];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
