//
//  LifeCycleViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/17.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LifeCycleViewController.h"
#import "LiftCycleHeader.h"
#import <Masonry.h>
#import "LiftCycleCell.h"
#import "RedBallButton.h"
#import <BottomComponentLib/UIImage+BCLib.h>
#import "PickerViewController.h"

@interface LifeCycleViewController ()
@property (nonatomic, strong) PickerViewController *pickerView;

@property (nonatomic, strong) RegionModel *selectedModel;
@end

@implementation LifeCycleViewController
//nib文件(xib,storyBoard)加载过程
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

// xib 加载 完成
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s", __FUNCTION__);
}

//-------------------------------------------------------

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

// 加载视图(默认从nib)
- (void)loadView {
    [super loadView];
    NSLog(@"%s", __FUNCTION__);
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.view.backgroundColor = [UIColor redColor];
}

//视图控制器中的视图加载完成，viewController自带的view加载完成
- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    //第一种
    UIColor *color = [UIColor redColor];
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"占位字符串" attributes:@{NSForegroundColorAttributeName: color}];
    //第二种
//    [_textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
}


//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillAppear:animated];
}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
}

// 视图被销毁
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (PickerViewController *)pickerView {
    if (!_pickerView) {
        _pickerView = [PickerViewController new];
    }
    return _pickerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.backgroundColor = [UIColor whiteColor];
    LiftCycleHeader *liftCycyle = [LiftCycleHeader liftCycleHeader];
    [liftCycyle setFrame:CGRectMake(20, 20, 100, 50)];
    
    [self.view addSubview:liftCycyle];
//    [liftCycyle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 50));
//        make.left.top.mas_equalTo(20);
//    }];
    

    LiftCycleCell *cell = [[LiftCycleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [self.view addSubview:cell];
    NSLog(@"cell:%@",cell);
    
    RedBallButton *btn = [[RedBallButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"99" forState:UIControlStateNormal];
    UIImage *gray = [UIImage pureImageWithColor:[UIColor lightGrayColor]];
    [btn setImage:gray forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    [self.pickerView showProvincePickerVC:^(NSString * res, NSInteger num, RegionModel * _Nonnull region) {
        NSLog(@"res:%@--num:%d",res,num);
    }];
    
    //selectedModel

}

@end
