//
//  XDebugDataControl.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugDataControl.h"

#define kPlistPath [[NSBundle mainBundle] pathForResource:@"XDebugNomalTools" ofType:@"plist"]

@implementation XDebugDataControl

+ (void)saveDataToXplist
{
    NSURL *fileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"myplist" ofType:@"plist"]];
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:kPlistPath];
//    NSLog(@"dict ---------> %@",dict);
    NSArray *words = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
    [words writeToURL:fileUrl atomically:YES];
    
}

//判断沙盒cache目录中是否存在plist，没有则写入plist

@end
