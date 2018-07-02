//
//  XDebugNormalDataManager.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/2.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugNormalDataManager.h"
#import "XDebugDataModel.h"

#define XPlistName @"XDebugNormalData.plist"

static XDebugNormalDataManager * _instance;

@implementation XDebugNormalDataManager

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

#pragma mark - method

+ (NSArray *)arrayFormSandBox
{
    //判断沙盒cache目录中是否存在plist，没有则写入plist
    NSArray *array = [NSArray array];
    
    if (![[XDebugNormalDataManager shared] isExistInSandBoxLibraryCachesWithFileName:XPlistName]) {
        array = @[@"haha",@"heihei"];
        NSString *path = [[XDebugNormalDataManager shared] createPlistInSandBoxLibraryCachesWithContent:array name:XPlistName];
        NSLog(@"path ---------> %@",path);
    }
    
    return [NSArray arrayWithContentsOfFile:[[[XDebugNormalDataManager shared] libraryCachesDirectory] stringByAppendingPathComponent:XPlistName]];
}

- (NSString *)libraryCachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//判断沙盒Doucument路径下是否有某文件
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

- (BOOL)deletePlistInSandBoxLibraryCachesWithFileName:(NSString *)fileName
{
    NSString *filePath = [[self libraryCachesDirectory] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }else{
        return [fileManager removeItemAtPath:filePath error:nil];
    }
}


@end
