//
//  XHttpResponseController.m
//  LEVE
//
//  Created by canoe on 2018/7/7.
//  Copyright © 2018年 dashuju. All rights reserved.
//

#import "XHttpResponseController.h"
#import "JxbHttpDatasource.h"
#import "XDebugBoxTipView.h"
#import "XMacros.h"

@interface XHttpResponseController ()

@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation XHttpResponseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.isImage) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.image = [UIImage imageWithData:self.data];
        [self.view addSubview:self.imageView];
        return;
    }
    
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
    self.textView.text = [JxbHttpDatasource prettyJSONStringFromData:self.data];
    
    [self.view addSubview:self.textView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.isImage) {
        self.imageView.frame = self.view.frame;
        return;
    }
    
    self.textView.frame  = self.view.bounds;
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:14],
                                 NSParagraphStyleAttributeName : style};
    CGRect r = [[JxbHttpDatasource prettyJSONStringFromData:self.data] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, MAXFLOAT) options:option attributes:attributes context:nil];
    self.textView.contentSize = CGSizeMake(self.view.bounds.size.width, r.size.height);
}

- (void)copyContent {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [self.textView.text copy];
    
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
