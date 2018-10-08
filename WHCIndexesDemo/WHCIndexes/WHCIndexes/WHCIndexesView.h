//
//  WHCIndexesView.h
//  whc2
//
//  Created by 汪弘昌 on 2018/10/8.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedIndexesTitle)(NSString *title);

@interface WHCIndexesView : UIView
/** 索引数据源*/
@property (nonatomic, strong)NSArray *whc_indexesArray;
/** 外部tableViewcell高度 默认44*/
@property (nonatomic, assign)CGFloat whc_cellHeight;
/** 索引tableViewcell高度*/
@property (nonatomic, assign)CGFloat whc_indexesCellHeight;
/** 外部tableView 数据源*/
@property (nonatomic, strong)NSArray *whc_dataArray;
+ (WHCIndexesView*)initUI:(UITableView *)tableView;
- (NSArray*)configPointArr;
- (void)computeCurrentItem:(selectedIndexesTitle)selectedIndexesTitle;
@end
