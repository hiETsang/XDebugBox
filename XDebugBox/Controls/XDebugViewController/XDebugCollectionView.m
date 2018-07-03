//
//  XDebugCollectionView.m
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import "XDebugCollectionView.h"
#import "XMacros.h"
#import "XDebugCollectionViewCell.h"
#import "XDebugDataModel.h"

@interface XDebugCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation XDebugCollectionView

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

+ (instancetype)debugCollectionViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kRatioWidth(130), 48 + kRatioHeight(21));
    layout.minimumLineSpacing = kRatioHeight(16);
    layout.minimumInteritemSpacing = kRatioWidth(20);
    layout.sectionInset = UIEdgeInsetsMake(kRatioHeight(8), kRatioWidth(20), kRatioHeight(16), kRatioWidth(20));
    
    XDebugCollectionView *collectionView = [[XDebugCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config
{
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    [self registerClass:[XDebugCollectionViewCell class] forCellWithReuseIdentifier:@"XDebugCollectionViewCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XDebugCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XDebugCollectionViewCell" forIndexPath:indexPath];
    XDebugDataModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.titleStr;
    cell.descLabel.text = model.detailStr;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    XDebugDataModel *model = self.dataArray[indexPath.row];
    if (self.didSelectedItem) {
        self.didSelectedItem(model);
    }
}

@end
