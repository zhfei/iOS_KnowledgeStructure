//
//  SearchViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/3.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,
UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic,retain) UISearchController *searchController;
@property (nonatomic,strong) UITableView *tableView;
//数据源
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) NSMutableArray *searchList;
@end

@implementation SearchViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

//MARK: View Auto-Rotation
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)dealloc {
    //指定context 防治父类移除后子类重复移除造成崩溃
    [self.searchController removeObserver:self forKeyPath:@"active" context:"SearchViewController"];
}

#pragma mark - Private Method

- (void)addUI {
    
}

- (void)setupUI {
    self.title = @"搜索列表";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.tableView];
}

- (void)setupLayout {
    
}

- (void)setupData {
    self.searchList = [NSMutableArray array];
    self.dataList = [NSMutableArray arrayWithCapacity:100];
    
    //产生100个数字+三个随机字母
    for (NSInteger i =0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }
    
    [self.searchController addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:"SearchViewController"];

}

//产生3个随机字母
- (NSString *)shuffledAlphabet {
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    NSString *strTest = [[NSString alloc] init];
    for (int i=0; i<3; i++) {
        int x = arc4random() % 25;
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
    }
    return strTest;
}


#pragma mark - Public Method

#pragma mark - Event
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.searchController) {
        NSLog(@"change: %@",change);
    } else {
        //子类处理完自己的事件后，交给父类继续处理
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Delegate
// MARK: UITableViewDelegate
//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchList count];
    } else {
        return [self.dataList count];
    }
}
//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    } else {
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    return cell;
}

// MARK: UISearchResultsUpdating
//谓词搜索过滤
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [_searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [_tableView reloadData];
}

// MARK: UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
#warning 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
    //    [self.view addSubview:_searchController.searchBar];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}

#pragma mark - Getter, Setter
- (UISearchController *)searchController {
    if (!_searchController) {
        //创建UISearchController
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate= self;
        _searchController.searchResultsUpdater = self;
        
        //包着搜索框外层的颜色
        _searchController.searchBar.barTintColor = [UIColor blueColor];
        _searchController.searchBar.placeholder= @"请输入关键字搜索";
        _searchController.searchBar.text = @"我是周杰伦";
        
        //搜索时，背景变暗色
        //    _searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时，背景变模糊
//        _searchController.obscuresBackgroundDuringPresentation = YES;
        //点击搜索的时候,是否隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
    }
    return _searchController;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,widthS ,heightS)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //隐藏tableViewCell下划线
        //    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableHeaderView = self.searchController.searchBar;
    }
    return _tableView;
}

#pragma mark - NSCopying

#pragma mark - NSObject


@end
