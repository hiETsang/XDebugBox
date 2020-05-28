//
//  XHttpContentController.m
//  LEVE
//
//  Created by canoe on 2017/7/7.
//  Copyright © 2019年 dashuju. All rights reserved.
//

#import "XHttpContentController.h"
#import "XDebugBoxTipView.h"
#import "XMacros.h"

@interface XHttpContentController ()

@property(nonatomic, strong) UITextView *textView;

@end

@implementation XHttpContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIButton *btnclear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btnclear.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btnclear setTitle:@"复制" forState:UIControlStateNormal];
    [btnclear setTitleColor:RGB(55, 55, 55) forState:UIControlStateNormal];
    [btnclear addTarget:self action:@selector(copyContent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btnclear];
    self.navigationItem.rightBarButtonItem = btnright;
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.textView setEditable:NO];
    self.textView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
    self.textView.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
    self.textView.text = self.content;

    if (@available(iOS 11.0, *)) {
        self.textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.textView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:14],
                                 NSParagraphStyleAttributeName : style};
    CGRect r = [self.content boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, MAXFLOAT) options:option attributes:attributes context:nil];
    self.textView.contentSize = CGSizeMake(self.view.bounds.size.width, r.size.height);
    self.textView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
}

- (void)copyContent {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [self.content copy];
    
    [XDebugBoxTipView showTip:@"复制成功"];
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
