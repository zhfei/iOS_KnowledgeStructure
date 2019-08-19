//
//  CustomNavigationBarVC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/14.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CustomNavigationBarVC.h"
#import <BottomComponentLib/UIView+BCLib.h>
#import <BottomComponentLib/UIImage+BCLib.h>

@interface CustomNavigationBarVC ()<UISearchBarDelegate>

@end

@implementation CustomNavigationBarVC
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method


- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //appearance:视图样式代理默认样式设置，所有的视图样式均可以使用，因为UIView实现了这个协议
    //[UINavigationBar appearance]：统一全局修改
    //⚠️：通过代理设置,UIAppearance为外观协议，要想改变外观就要实现外观协议协议，（装饰器模式）
    //⚠️：使用appearance设置只会在view layout time 时生效，否则无效。
    //⚠️: 1与2互斥，且1的优先级高
    //1.设置导航背景
    UIImage *bg = [UIImage pureImageWithColor:[UIColor brownColor]];
    [self.navigationController.navigationBar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
    //2.设置导航颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    //3.设置导航文字颜色
    [self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
    //设置导航字体
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];

    
    CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
    CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
    //中间title自定义
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,widthS-100,35)];
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self ;
    searchBar.frame=CGRectMake(0,0,titleView.frame.size.width,35);
    searchBar.layer.cornerRadius=18;
    searchBar.layer.masksToBounds=YES;
    //边框线粗细
    [searchBar.layer setBorderWidth:8];
    //设置边框为白色是为了盖住UISearchBar上的灰色
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    searchBar.placeholder=@"搜索你想要的东西";
    [titleView addSubview:searchBar];
    self.navigationItem.titleView= titleView;
    
    
    //设置多个导航按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
//    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
//    NSArray *actionButtonItems = @[shareItem, cameraItem];
//    self.navigationItem.rightBarButtonItems = actionButtonItems;
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)setupLayout {
     NSPredicate *predice =[NSPredicate predicateWithFormat:@""];
}

- (void)setupData {
    
}

- (void)resetUI {

}

- (void)resetLayout {
    
}

- (void)resetData {
    
}


#pragma mark - Delegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

#pragma mark - NSCopying

#pragma mark - NSObject

@end
