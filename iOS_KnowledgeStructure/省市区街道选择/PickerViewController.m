//
//  PickerViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *picker;
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
    [self.view addSubview:self.picker];
}

#pragma mark - Getter, Setter
- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc] init];
        _picker.delegate = self;
        _picker.dataSource = self;
        
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
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}
#pragma mark - NSCopying

#pragma mark - NSObject

@end
