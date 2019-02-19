//
//  PickerViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "PickerViewController.h"
#import "PickerViewViewModel.h"
#import <Masonry.h>

@interface PickerViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray <PVAreaModel *>* dataSource;
@end

@implementation PickerViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    self.dataSource = [PickerViewViewModel dataSource];
}

#pragma mark - Getter, Setter
- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc] init];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.showsSelectionIndicator = YES;
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        
        [_picker setFrame:CGRectMake(0, 200, widthS, 200)];
    }
    return _picker;
}
#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method


- (void)setupUI {
    [self.view addSubview:self.picker];
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(260);
    }];
}

- (void)setupLayout {
    
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
/** 设置组件中每行的标题row:行 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.dataSource[row] name];
    }else{
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        NSArray *arr = [[self.dataSource objectAtIndex:selectedRow] datas];
        
        return [[arr objectAtIndex:row] name];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
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
    return 10;
}

/** 当选择某一个列中的某一行的时候会调用该方法 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //在拖动第 0 列行的时候, 要及时的刷新第 1 列的数据
    if (component == 0) {
        //如果滑动的是第 0 列, 刷新第 1 列
        //在执行完这句代码之后, 会重新计算第 1 列的行数, 重新加载第 1 列的标题内容
        [pickerView reloadComponent:1];//重新加载指定列的数据
        [pickerView selectRow:0 inComponent:1 animated:YES];
        //
        
        //重新加载数据
        //[pickerView reloadAllComponents];
    }
}
#pragma mark - NSCopying

#pragma mark - NSObject

@end
