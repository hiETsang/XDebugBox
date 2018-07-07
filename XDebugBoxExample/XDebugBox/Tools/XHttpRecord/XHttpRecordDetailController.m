//
//  XHttpRecordDetailController.m
//  LEVE
//
//  Created by canoe on 2018/7/7.
//  Copyright © 2018年 dashuju. All rights reserved.
//

#import "XHttpRecordDetailController.h"
#import "XHttpContentController.h"
#import "XHttpResponseController.h"
#import "XMacros.h"

#define detailTitles   @[@"Request Url",@"Method",@"Status Code",@"Mime Type",@"Start Time",@"Total Duration",@"Request Body",@"Response Body"]

@interface XHttpRecordDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView  *tableView;

@end

@implementation XHttpRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请求详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"httpdetailcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:17];
        cell.textLabel.textColor = RGB(255, 83, 77);
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    }
    NSString* value = @"";
    if (indexPath.row == 0) {
        value = self.detail.url.absoluteString;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 1) {
        value = self.detail.method;
    }
    else if (indexPath.row == 2) {
        value = self.detail.statusCode;
    }
    else if (indexPath.row == 3) {
        value = self.detail.mineType;
    }
    else if (indexPath.row == 4) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        value = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.detail.startTime.doubleValue]];
    }
    else if (indexPath.row == 5) {
        value = self.detail.totalDuration;
    }
    else if (indexPath.row == 6) {
        if (self.detail.requestBody.length > 0) {
            value = @"Tap to view";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            value = @"Empty";
        }
    }
    else if (indexPath.row == 7) {
        NSInteger lenght = self.detail.responseData.length;
        if (lenght > 0) {
            if (lenght < 1024) {
                value = [NSString stringWithFormat:@"(%zdB) Tap to view",lenght];
            }
            else {
                value = [NSString stringWithFormat:@"(%.2fKB) Tap to view",1.0 * lenght / 1024];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            value = @"Empty";
        }
    }
    cell.textLabel.text = [detailTitles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = value;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        XHttpContentController* vc = [[XHttpContentController alloc] init];
        vc.content = self.detail.url.absoluteString;
        vc.title = @"接口地址";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 6 && self.detail.requestBody.length > 0) {
        XHttpContentController* vc = [[XHttpContentController alloc] init];
        vc.content = self.detail.requestBody;
        vc.title = @"请求数据";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 7 && self.detail.responseData.length > 0) {
        XHttpResponseController* vc = [[XHttpResponseController alloc] init];
        vc.data = self.detail.responseData;
        vc.isImage = self.detail.isImage;
        vc.title = @"返回数据";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        return;
    }
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
