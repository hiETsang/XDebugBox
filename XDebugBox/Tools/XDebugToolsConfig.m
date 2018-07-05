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
#import "XDebugBoxTipView.h"
#import "XClearCache.h"

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
                kNormalDetail:@"方便查看和调试动画效果",
                kNormalAutoClose:@(0),
                kNormalMethodName:@"changeAnimationSpeed:"
                },
              @{kNormalTitle:@"缓存清理",
                kNormalDetail:@"清理沙盒路径Cache文件夹中的缓存文件",
                kNormalAutoClose:@(0),
                kNormalMethodName:@"ClearCache:"
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
//改变全局动画速度
-(void)changeAnimationSpeed:(XDebugViewController *)viewController
{
    XAnimationSpeedController *vc = [[XAnimationSpeedController alloc] init];
    vc.title = @"调整全局动画速度";
    [viewController.navigationController pushViewController:vc animated:YES];
}

//清理缓存
- (void)ClearCache:(XDebugViewController *)viewController
{
    NSString *size = [XClearCache getCacheSize];
    if ([XClearCache cleanAppCache]) {
        [XDebugBoxTipView showTip:[NSString stringWithFormat:@"%@缓存清理成功",size]];
    }else
    {
        [XDebugBoxTipView showTip:@"缓存清理失败\n请查看控制台输出的路径"];
    }
}

//刷新通用方法列表
- (void)reloadNormalList:(XDebugViewController *)viewController
{
    [[XDebugNormalDataManager shared] deletePlistInSandBoxLibraryCaches];
    [XDebugBoxManager shared].normalArray = [XDebugNormalDataManager arrayFormSandBox];
    [XDebugBoxTipView showTip:@"已刷新"];
}

#pragma mark - dealloc

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
