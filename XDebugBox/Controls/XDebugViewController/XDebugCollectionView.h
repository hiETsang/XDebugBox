//
//  XDebugCollectionView.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/6/29.
//  Copyright © 2018年 canoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDebugCollectionView : UICollectionView

+ (instancetype)debugCollectionViewWithFrame:(CGRect)frame;

@property(nonatomic, strong) NSMutableArray *dataArray;

@end
