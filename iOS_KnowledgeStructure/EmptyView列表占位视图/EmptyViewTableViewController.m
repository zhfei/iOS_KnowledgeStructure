//
//  EmptyViewTableViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/22.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "EmptyViewTableViewController.h"
#import <Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

static NSString *cellID =@"myCell";

@interface EmptyViewTableViewController () <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign, getter=isLoading) BOOL loading;
@end

@implementation EmptyViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetData];
}

#pragma mark - Life Cycle

#pragma mark - Getter, Setter
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat widthV = self.view.frame.size.width;
        CGFloat heightV = self.view.frame.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, widthV, heightV) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"1",@"2",@"3"].mutableCopy;
    } else {
        _dataSource = nil;
    }
    return _dataSource;
}
#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)addUI {
    [self.view addSubview:self.tableView];
}

- (void)setupUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 50;
    
    __weak typeof(self)weakSelf=self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
        });
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉刷新...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)setupLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setupData {
    
}

- (void)resetData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupEmptyDataSet {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

#pragma mark - Delegate
// !!!: TableView
#pragma mark dataSource
//header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
//footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
//cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @"内容...";
    
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// !!!: DZNEmptyDataSet
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"数据为空！！"];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"这里再描述一下"];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"dogAndDuck"];
}
- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor purpleColor];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [[NSAttributedString alloc] initWithString:@"这里是按钮的标题"];
}


// MARK:emptyDataSet代理
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}


#pragma mark - NSCopying

#pragma mark - NSObject

@end

