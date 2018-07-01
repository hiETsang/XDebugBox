//
//  XDebugViewController.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/25.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugViewController.h"
#import "XDebugContainerWindow.h"
#import "XDebugWindowManager.h"
#import "XDebugBoxManager.h"
#import "XDebugNavigationController.h"
#import "XDebugSwitchView.h"
#import "XDebugCollectionView.h"
#import "XMacros.h"


static NSString *const kXDebugViewController = @"XDebugViewControllerKey";

@interface XDebugViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong) XDebugSwitchView *switchView;
@property(nonatomic, strong) XDebugCollectionView *collectionView;

@end

@implementation XDebugViewController

#pragma mark - public

+ (instancetype)debugViewController
{
    return [[self alloc] init];
}

- (void)showWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXDebugViewController];
    if (!window) {
        window = [self configWindow];
    }
    
    window.hidden = NO;
}

- (void)removeWithAnimation
{
    UIWindow *window = [XDebugWindowManager windowForkey:kXDebugViewController];
    if (!window) {
        return;
    }
    
    window.hidden = YES;
    [XDebugWindowManager removeWindowForKey:kXDebugViewController];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self addObserverForData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.switchView.frame = CGRectMake(0, 44, self.view.frame.size.width, kRatioHeight(57));
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.switchView.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.switchView.frame));
}

- (void)configUI
{
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    titleImageView.image = [UIImage imageNamed:@"logo"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 34, 34)];
    [view addSubview:titleImageView];
    self.navigationItem.titleView = view;
    
    XDebugSwitchView *switchView = [[XDebugSwitchView alloc] init];
    [self.view addSubview:switchView];
    self.switchView = switchView;
    
    [switchView setDidSwitchType:^(XDebugSwitchView *switchView, XDebugSwitchViewType type) {
        if (type == XDebugSwitchViewTypeNormal) {
            [self reloadNormalData];
        }else
        {
            [self reloadExtensionData];
        }
    }];
    
    XDebugCollectionView *collectionView = [XDebugCollectionView debugCollectionViewWithFrame:CGRectZero];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (UIWindow *)configWindow
{
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    XDebugContainerWindow *window = [[XDebugContainerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = window.windowLevel - 2;
    window.rootViewController = [[XDebugNavigationController alloc] initWithRootViewController:self];
    [window makeKeyAndVisible];
    [currentWindow makeKeyWindow];
    
    window.hidden = YES;
    window.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [XDebugWindowManager saveWindow:window ForKey:kXDebugViewController];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDebugWindow:)];
    tap.delegate = self;
    [window addGestureRecognizer:tap];
    
    return window;
}

#pragma mark - actions

- (void)addObserverForData {
    [self addObserver:[XDebugBoxManager shared] forKeyPath:@"extensionArray" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:[XDebugBoxManager shared] forKeyPath:@"normalArray" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"normalArray"] && self.switchView.type == XDebugSwitchViewTypeNormal) {
        self.collectionView.dataArray = [XDebugBoxManager shared].normalArray;
    }else if([keyPath isEqualToString:@"normalArray"] && self.switchView.type == XDebugSwitchViewTypeNormal)
    {
        self.collectionView.dataArray = [XDebugBoxManager shared].extensionArray;
    }
}

-(void)tapDebugWindow:(UITapGestureRecognizer *)tap
{
    if (self.tapWindow) {
        self.tapWindow(self);
    }
}

- (void)reloadNormalData {
    self.collectionView.dataArray = [XDebugBoxManager shared].normalArray;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromRight;
    [self.collectionView.layer addAnimation:transition forKey:nil];
    [self.collectionView reloadData];
}

- (void)reloadExtensionData {
    self.collectionView.dataArray = [XDebugBoxManager shared].extensionArray;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    [self.collectionView.layer addAnimation:transition forKey:nil];
    [self.collectionView reloadData];

}


#pragma mark - gestureDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    return !CGRectContainsPoint(self.view.bounds, point);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
