//
//  XDebugNormalDataManager.m
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/2.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import "XDebugNormalDataManager.h"
#import "XDebugDataModel.h"
#import "XDebugToolsConfig.h"

#define XPlistName @"XDebugNormalData.plist"

static XDebugNormalDataManager * _instance;

static dispatch_once_t onceToken;

@interface XDebugNormalDataManager ()

@property(nonatomic, strong) XDebugToolsConfig *config;

@end

@implementation XDebugNormalDataManager

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

- (XDebugToolsConfig *)config
{
    if (!_config) {
        _config = [[XDebugToolsConfig alloc] init];
    }
    return _config;
}

+ (void)sharedDelloc
{
    onceToken = 0;
    _instance = nil;
}


#pragma mark - normalDataMethod

+ (NSArray *)arrayFormSandBox
{
    //判断沙盒cache目录中是否存在plist，没有则写入plist
    NSArray *array = [NSArray array];
    
    if (![[XDebugNormalDataManager shared] isExistInSandBoxLibraryCachesWithFileName:XPlistName]) {
        array = [XDebugNormalDataManager shared].config.array;
        NSString *path = [[XDebugNormalDataManager shared] createPlistInSandBoxLibraryCachesWithContent:array name:XPlistName];
        NSLog(@"通用工具数组本地存储路径 ---------> %@",path);
    }
    array = [[XDebugNormalDataManager shared].config debugModelArrayWithDictArray:[NSArray arrayWithContentsOfFile:[[[XDebugNormalDataManager shared] libraryCachesDirectory] stringByAppendingPathComponent:XPlistName]]];
    return array;
}

- (NSString *)libraryCachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (BOOL)isExistInSandBoxLibraryCachesWithFileName:(NSString *)fileName
{
    NSString *filePath = [[self libraryCachesDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath])
    {
        return NO;
    }else{
        return YES;
    }
}

- (NSString *)createPlistInSandBoxLibraryCachesWithContent:(id)content name:(NSString *)name
{
    NSString *filePath = [[self libraryCachesDirectory] stringByAppendingPathComponent:name];
    [content writeToFile:filePath atomically:YES];
    return filePath;
}

- (BOOL)deletePlistInSandBoxLibraryCaches
{
    NSString *filePath = [[self libraryCachesDirectory] stringByAppendingPathComponent:XPlistName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }else{
        return [fileManager removeItemAtPath:filePath error:nil];
    }
}


@end
