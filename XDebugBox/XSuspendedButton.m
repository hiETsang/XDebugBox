//
//  XSuspendedButton.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XSuspendedButton.h"

#define kStayProportion (8/55.0)
#define kVerticalMargin 15.0

@implementation XSuspendedButton

+ (instancetype) suspendedButtonWithDelegate:(id<XSuspendedButtonDelegate>)delegate
{
    return [[self alloc] initWithFrame:CGRectMake(-kStayProportion * 55, 300, 55, 55) delegate:delegate];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame delegate:nil];
}

-(instancetype)initWithFrame:(CGRect)frame delegate:(id<XSuspendedButtonDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.alpha = 0.9;
        self.layer.borderColor = [UIColor colorWithWhite:0.2 alpha:0.7].CGColor;
        self.layer.borderWidth = 5;
        self.clipsToBounds = YES;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


#pragma mark - public



#pragma mark - event


@end
