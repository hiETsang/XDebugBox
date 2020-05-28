//
//  XHttpRecordController.m
//  LEVE
//
//  Created by canoe on 2017/7/6.
//  Copyright © 2019年 dashuju. All rights reserved.
//

#import "XHttpRecordController.h"
#import "XHttpRecorder.h"
#import "XHttpRecordDetailController.h"
#import "XMacros.h"
#import "XNetworkObserver.h"
#import "XDebugBoxTipView.h"

@interface XHttpRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation XHttpRecordController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHttp) name:kXHttpRecorderNewTransactionNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHttp) name:kXHttpRecorderTransactionUpdatedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHttp) name:kXHttpRecorderTransactionsClearedNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络请求记录";
    
    UIButton *btnclear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btnclear.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btnclear setTitle:@"清空" forState:UIControlStateNormal];
    [btnclear setTitleColor:RGB(55, 55, 55) forState:UIControlStateNormal];
    [btnclear addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btnclear];
    
    UISwitch *close = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    close.on = [XNetworkObserver isEnabled];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithCustomView:close];
    [close addTarget:self action:@selector(swicthNetworkObsever:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItems = @[btnright,closeBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.tableFooterView = [[UIView alloc]init];

    [self reloadHttp];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
}

- (void)swicthNetworkObsever:(UISwitch *)close {
    if (close.isOn) {
        [XNetworkObserver setEnabled:YES];
        [XDebugBoxTipView showTip:@"网络监听已开启"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XDebugBoxTipView showTip:@"网络监听有可能造成偶尔的闪退\n请在需要时使用" duration:2.0];
        });
    }else
    {
        [XNetworkObserver setEnabled:NO];
        [XDebugBoxTipView showTip:@"已关闭网络监听"];
    }
}

- (void)clearAction {
    [[XHttpRecorder defaultRecorder] clear];
}

- (void)reloadHttp {
    self.dataArray = [[[XHttpRecorder defaultRecorder] httpArray] copy];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:17];
        cell.textLabel.textColor = RGB(255, 83, 77);
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    }
    XHttpModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [model.method stringByAppendingString:[NSString stringWithFormat:@": %@",model.url.host]];
    cell.detailTextLabel.text = model.url.path;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XHttpRecordDetailController *vc = [[XHttpRecordDetailController alloc] init];
    vc.detail = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
