//
//  WHCIndexesViewController.m
//  whc2
//
//  Created by 汪弘昌 on 2018/9/30.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import "WHCIndexesViewController.h"
#import "WHCIndexesTableViewCell.h"
#import "WHCIndexesView.h"
@interface WHCIndexesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, assign)NSInteger indexesCellHeight;
@property (nonatomic, assign)NSInteger cellHeight;
@property (nonatomic, strong)NSArray *pointArr;
@property (nonatomic, strong)WHCIndexesView *indexesView;
@end

@implementation WHCIndexesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _cellHeight = 44;
    _indexesCellHeight = 44;
    [self configData];
    [self configTableView];
    [self configIndexesView];
    
}
#pragma mark ************data
- (void)configData
{
    _dataArray = [NSMutableArray array];
    NSArray *arr = @[@"我们",@"你们",@"他们",@"我们",@"你们",@"他们",@"我们",@"你们",@"他们",@"我们",@"你们",@"他们",@"我们",@"你们",@"他们"];
    _titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
    for (NSInteger i = 0; i < _titleArray.count; i++ ) {
        [_dataArray addObject:arr];
    }
}




#pragma mark ************UI
- (void)configIndexesView
{
    self.indexesView = [WHCIndexesView initUI:_tableview];
    [self.view addSubview:self.indexesView];
    self.indexesView.whc_dataArray = _dataArray;
    self.indexesView.whc_indexesArray = _titleArray;
    self.indexesView.whc_cellHeight = _cellHeight;
    self.indexesView.whc_indexesCellHeight = _indexesCellHeight;
    _pointArr = [self.indexesView configPointArr];
}
- (void)configTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    [self registerCell];
}
- (void)registerCell
{
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WHCIndexesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([WHCIndexesTableViewCell class])];
    
}
#pragma mark ************tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHCIndexesTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:NSStringFromClass([WHCIndexesTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.descStr = _dataArray[indexPath.section][indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    NSString *title = self.titleArray[section];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [myView  addSubview:titleLabel];
    return myView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_indexesView computeCurrentItem:^(NSString *title) {
        NSLog(@"%@",title);
    }];
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
