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
#import <BottomComponentLib/UIColor+BCLib.h>

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
            [weakSelf.tableView reloadEmptyDataSet];
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
    [self setupEmptyDataSet];
}

- (void)resetData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupEmptyDataSet {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
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
/**
 *  返回标题文字
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"No Application Found";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}
/**
 *  返回详情文字
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {

    NSString *tmp = @"hello world";
    
    NSString *text = [NSString stringWithFormat:@"There are no empty dataset examples for \"%@\".", tmp];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[attributedString.string rangeOfString:tmp]];
    
    return attributedString;
}
/**
 *  返回文字按钮
 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"Search on the App Store";
    UIFont *font = [UIFont systemFontOfSize:16.0];
    UIColor *textColor = [UIColor colorWithHexString:(state == UIControlStateNormal) ? @"007aff" : @"c6def9" alpha:1];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
/**
 *  返回图片按钮
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@""];
}
/**
 *  自定义背景颜色
 */
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}
/**
 *  设置垂直或者水平方向的偏移量，推荐使用verticalOffsetForEmptyDataSet这个方法
 *
 *  @return 返回对应的偏移量（默认都为0）
 */
- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -64.0);
}
/**
 *  设置垂直方向的偏移量
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -64.0;
}



// MARK:emptyDataSet代理
/**
 *  数据源为空时是否渲染和显示 (默认为 YES)
 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
/**
 *  是否允许点击 (默认为 YES)
 */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
/**
 *  是否允许滚动 (默认为 NO)
 */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
/**
 *  处理空白区域的点击事件
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    NSLog(@"%s",__FUNCTION__);
}
/**
 *  处理按钮的点击事件
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.com/apps/%@", searchBar.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    }
}


#pragma mark - NSCopying

#pragma mark - NSObject

@end

