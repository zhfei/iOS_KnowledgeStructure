//
//  PickerViewController+delegate.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/20.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "PickerViewController+delegate.h"

@implementation PickerViewController (delegate)
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

@end
