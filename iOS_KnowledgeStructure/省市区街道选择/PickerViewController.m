//
//  PickerViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//


#import "PickerViewController.h"
#import <Masonry.h>
#import "LabelContainer.h"
#import <BottomComponentLib/UIView+coreAnimation.h>

CGFloat const kContentHeigh = 244.0;


@interface PickerViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSArray <PVAreaModel *>* dataSource;
@property (nonatomic, strong) NSArray <RegionModel *>* dataSource2;
@property (nonatomic, copy) CompleteBlock completeBlock;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITextField *textView;
@property (nonatomic, strong) LabelContainer *labelContainer;
@end

@implementation PickerViewController
#pragma mark - Life Cycle
+ (instancetype)cityPickerController {
    PickerViewController *pickerVC = [[PickerViewController alloc] init];
    return pickerVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Getter, Setter
- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc] init];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.showsSelectionIndicator = YES;
    }
    return _picker;
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        UIToolbar *bar = [[UIToolbar alloc] init];
        bar.barStyle = UIBarStyleDefault;
        
        NSMutableArray *barItems = [NSMutableArray array];
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"\t取消" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCanelClick)];
        [barItems addObject:cancelBtn];
        // 中间弹簧，将取消、确定分隔在左右两端
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定\t" style:UIBarButtonItemStyleDone target:self action:@selector(finishBtnClick:)];
        // 添加的顺序是从左至右，按顺序来的，并且相隔的距离都很近，不远，但添加弹簧后自适应最适合的位置
        [barItems addObject:doneBtn];
        bar.items = barItems;
        
        _toolbar = bar;
    }
    return _toolbar;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor whiteColor];
    }
    return _line;
}

- (UITextField *)textView {
    if (!_textView) {
        _textView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, 0)];
        _textView.inputView = self.picker;
        _textView.inputAccessoryView = self.toolbar;
    }
    return _textView;
}

- (LabelContainer *)labelContainer {
    if (!_labelContainer) {
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        _labelContainer = [[LabelContainer alloc] initWithFrame:CGRectMake(0, 100, widthS, 100)];
        _labelContainer.backgroundColor = [UIColor brownColor];
    }
    return _labelContainer;
}

#pragma mark - Event
- (void)toolBarCanelClick {
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(kContentHeigh);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)finishBtnClick:(UIBarButtonItem *)sender {
    
    NSUInteger count = [self.picker numberOfComponents];
    NSInteger num = [self.picker selectedRowInComponent:0];
    RegionModel *model = self.dataSource2[num];
    NSMutableString *resStr = model.name.mutableCopy;
    for (int i = 1; i < count; i++) {
        num = [self.picker selectedRowInComponent:i];
        model = model.children[num];
        [resStr appendString:@" "];
        [resStr appendString:model.name];
    }
    if (self.completeBlock) {
        self.completeBlock(resStr,count>1?0:1,model);
    }

    
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(kContentHeigh);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (model.children.count) {
            self.dataSource2 = model.children;
            [self.picker reloadAllComponents];
            [self.picker selectRow:0 inComponent:0 animated:NO];
            [UIView animateWithDuration:0.5 animations:^{
                [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(0);
                }];
                [self.view layoutIfNeeded];
            }];
        } else {
            [self dismiss];
        }
    }];
}

#pragma mark - Public Method
- (void)showProvincePickerVC:(CompleteBlock)completeBlock {
    if (!self.view.superview && !self.parentViewController) {
        self.completeBlock = completeBlock;
        //弹出选择器
        [PickerViewController loadAndShowVC:self];
        [self.picker reloadAllComponents];
        [self.picker selectRow:0 inComponent:0 animated:NO];
    }
}

- (void)showStreetPickerVC:(CompleteBlock)completeBlock streetArray:(NSArray *)streetArray {
    if (!self.view.superview && !self.parentViewController) {
        self.completeBlock = completeBlock;
        //弹出选择器
        [PickerViewController loadAndShowVC:self];
        self.dataSource = streetArray;
        [self.picker reloadAllComponents];
        [self.picker selectRow:0 inComponent:0 animated:NO];
    }
}

- (void)dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
#pragma mark - Private Method
- (void)addUI {
    [self.view addSubview:self.textView];
    [self.view addSubview:self.labelContainer];
    
    self.labelContainer.addTranslAnim(0.5,10.5);
    
//    [self.view addSubview:self.contentView];
//    [self.contentView addSubview:self.picker];
//    [self.contentView addSubview:self.line];
//    [self.contentView addSubview:self.toolbar];
}

- (void)setupUI {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupLayout {
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_equalTo(0);
//        make.height.mas_equalTo(kContentHeigh);
//    }];
    
//    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(0);
//        make.height.mas_equalTo(44);
//    }];
//
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.equalTo(self.toolbar.mas_bottom);
//        make.height.mas_equalTo(0.5);
//    }];
//
//    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_equalTo(0);
//        make.top.equalTo(self.line.mas_bottom);
//    }];
    [self.textView becomeFirstResponder];
}

- (void)setupData {
    self.dataSource = [PickerViewViewModel dataSource];
    self.dataSource2 = [PickerViewViewModel dataSource2];
    [self.picker reloadAllComponents];
}

+ (void)loadAndShowVC:(UIViewController *)vc {
    id<UIApplicationDelegate>appDelegate = [UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    [rootVC addChildViewController:vc];
    [rootVC.view addSubview:vc.view];
    
    CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
    CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
    [vc.view setFrame:CGRectMake(0, heightS, widthS, kContentHeigh)];
    
    [UIView animateWithDuration:0.5 animations:^{
        [vc.view setFrame:CGRectMake(0, heightS-kContentHeigh, widthS, kContentHeigh)];
    }];
}



#pragma mark - Delegate
/** 设置组件中每行的标题row:行 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        if (row+1 > [self.dataSource2 count]) {
            return @"";
        }
        return [self.dataSource2[row] name];
    } else if (component == 1) {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        if (selectedRow+1 > [self.dataSource2 count]) {
            return @"";
        }
        NSArray *arr = [[self.dataSource2 objectAtIndex:selectedRow] children];
        if (row+1 > [arr count]) {
            return @"";
        }
        return [[arr objectAtIndex:row] name];
    } else {
        NSInteger selectedRow0 = [pickerView selectedRowInComponent:0];
        NSInteger selectedRow1 = [pickerView selectedRowInComponent:1];
        
        if (selectedRow0+1 > [self.dataSource2 count]) {
            return @"";
        }
        NSArray *arr0 = [[self.dataSource2 objectAtIndex:selectedRow0] children];
        if (selectedRow1+1 > [arr0 count]) {
            return @"";
        }
        NSArray *arr = [[arr0 objectAtIndex:selectedRow1] children];
        if (row+1 > [arr count]) {
            return @"";
        }
        return [[arr objectAtIndex:row] name];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    RegionModel *model = [self.dataSource2 firstObject];
    if ([model.children count] == 0) {
        return 1;
    }
    
    RegionModel *model0 = [model.children firstObject];
    if ([model0.children count] == 0) {
        return 2;
    }
    
    return 3;
}

///** 设置组件的宽度 */
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    if (component == 0) {
//        return 60;
//    }else{
//        return 80;
//    }
//
//}
///** 设置组件中每行的高度 */
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    if (component == 0) {
//        return 50;
//    }else{
//        return 50;
//    }
//}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.dataSource2 count];
    } else if (component == 1) {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        if (selectedRow+1 > [self.dataSource2 count]) {
            return 0;
        }
        NSArray *arr = [[self.dataSource2 objectAtIndex:selectedRow] children];
        return [arr count];
    } else {
        NSInteger selectedRow0 = [pickerView selectedRowInComponent:0];
        NSInteger selectedRow1 = [pickerView selectedRowInComponent:1];
        if (selectedRow0+1 > [self.dataSource2 count]) {
            return 0;
        }
        NSArray *arr0 = [[self.dataSource2 objectAtIndex:selectedRow0] children];
        if (selectedRow1+1 > [arr0 count]) {
            return 0;
        }
        NSArray *arr = [[arr0 objectAtIndex:selectedRow1] children];
        
        return [arr count];
    }
}

/** 当选择某一个列中的某一行的时候会调用该方法 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //在拖动第 0 列行的时候, 要及时的刷新第 1 列的数据
    if (component == 0) {
        //如果滑动的是第 0 列, 刷新第 1 列
        //在执行完这句代码之后, 会重新计算第 1 列的行数, 重新加载第 1 列的标题内容
        
        if ([pickerView numberOfComponents] > 1) {
            [pickerView reloadComponent:1];//重新加载指定列的数据
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
        
        if ([pickerView numberOfComponents] > 2) {
            [pickerView reloadComponent:2];//重新加载指定列的数据
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        
    } else if (component == 1) {
        if ([pickerView numberOfComponents] > 2) {
            [pickerView reloadComponent:2];//重新加载指定列的数据
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
}

#pragma mark - NSCopying

#pragma mark - NSObject

@end
