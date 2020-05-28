//
//  XDebugCollectionView.h
//  XDebugBoxExample
//
//  Created by canoe on 2017/6/29.
//  Copyright © 2019年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDebugDataModel;
@interface XDebugCollectionView : UICollectionView

+ (instancetype)debugCollectionViewWithFrame:(CGRect)frame;

@property(nonatomic, strong) NSArray *dataArray;

/** didSelectedItem */
@property (nonatomic,copy) void (^didSelectedItem)(XDebugDataModel *model);

@end
