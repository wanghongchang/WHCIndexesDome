//
//  WHCIndexesView.m
//  whc2
//
//  Created by 汪弘昌 on 2018/10/8.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import "WHCIndexesView.h"
#import "WHCIndexesTableViewCell.h"
#import <MJRefresh.h>
@interface WHCIndexesView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *indexesTableView;
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong)NSArray *pointArr;
@property (nonatomic, copy)NSString *currentItem;
@end

@implementation WHCIndexesView

+ (WHCIndexesView*)initUI:(UITableView *)tableView
{
    WHCIndexesView *indexesView = [[WHCIndexesView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 0, 30, [UIScreen mainScreen].bounds.size.height)];
    indexesView.tableView = tableView;
    return indexesView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configIndexesTableView];
        [self initialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configIndexesTableView];
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configIndexesTableView];
    [self initialize];
}

#pragma mark ************setter
- (void)setWhc_indexesArray:(NSArray *)whc_indexesArray
{
    _whc_indexesArray = whc_indexesArray;
    [self whc_reloadData];
}
- (void)setWhc_indexesCellHeight:(CGFloat)whc_indexesCellHeight
{
    _whc_indexesCellHeight = whc_indexesCellHeight;
    [self whc_reloadData];
}
- (void)setWhc_cellHeight:(CGFloat)whc_cellHeight
{
    _whc_cellHeight = whc_cellHeight;
    [self whc_reloadData];
}
- (void)setWhc_dataArray:(NSArray *)whc_dataArray
{
    _whc_dataArray = whc_dataArray;
    [self whc_reloadData];
}
#pragma mark ************UI 默认
- (void)initialize
{
    _whc_cellHeight = 44;
    _whc_indexesCellHeight = 44;
    _pointArr = [NSMutableArray array];
}
- (void)configIndexesTableView
{
    _indexesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 0) style:UITableViewStylePlain];
    _indexesTableView.scrollEnabled = NO;
    _indexesTableView.delegate = self;
    _indexesTableView.dataSource = self;
    _indexesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _indexesTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_indexesTableView];
    [_indexesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WHCIndexesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([WHCIndexesTableViewCell class])];
}
#pragma mark ************tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _whc_indexesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHCIndexesTableViewCell *cell = [_indexesTableView dequeueReusableCellWithIdentifier:NSStringFromClass([WHCIndexesTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.descStr = _whc_indexesArray[indexPath.item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _whc_indexesCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.item;
        
    CGPoint point = CGPointMake(0, ([self computeContentOffset:index] * _whc_cellHeight + index * _whc_indexesCellHeight) - 20) ;
    [_tableView setContentOffset:point animated:NO];
}
#pragma mark ************私有方法
- (NSInteger)computeContentOffset:(NSInteger)index
{
    NSMutableArray *newArr = [NSMutableArray array];
    for (NSInteger i = 0; i < index; i++ )
    {
        NSArray *arr = _whc_dataArray[i];
        for (NSInteger j = 0; j < arr.count; j++ )
        {
            [newArr addObject:arr[j]];
        }
    }
    return newArr.count;
}

- (NSArray*)configPointArr
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < _whc_indexesArray.count; i++ ) {
        NSInteger y = ([self computeContentOffset:i] * _whc_cellHeight + i * _whc_indexesCellHeight) - 20;
        [arr addObject:[NSString stringWithFormat:@"%ld",y]];
    }
    return arr;
}

- (void)computeCurrentItem:(selectedIndexesTitle)selectedIndexesTitle
{
    _pointArr = [self configPointArr];
    CGPoint point = self.tableView.contentOffset;
    for (NSInteger i = 0; i < _pointArr.count; i++ )
    {
        if (i != _pointArr.count - 1)
        {
            if ((point.y < [_pointArr[i + 1] integerValue] && point.y > [_pointArr[i] integerValue]) || point.y == [_pointArr[i] integerValue])
            {
                if (![self.currentItem isEqualToString:_whc_indexesArray[i]])
                {
                    self.currentItem = _whc_indexesArray[i];
                    selectedIndexesTitle(self.currentItem);
                }
                break;
            }
        }
        else
        {
            if (point.y >= [_pointArr[i] integerValue] )
            {
                if (![self.currentItem isEqualToString:_whc_indexesArray[i]])
                {
                    self.currentItem = _whc_indexesArray[i];
                    selectedIndexesTitle(self.currentItem);
                }
                break;
            }
        }
        
    }
}


- (void)whc_reloadData
{
    self.indexesTableView.mj_y = (self.mj_h - (_whc_indexesCellHeight * _whc_indexesArray.count))/2;
    self.indexesTableView.mj_h = _whc_indexesCellHeight * _whc_indexesArray.count;
    if (self.whc_indexesArray.count > 0 && self.whc_indexesArray)
    {
        [self.indexesTableView reloadData];
    }
}

@end
