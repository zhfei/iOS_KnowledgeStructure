//
//  PickerViewController.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewViewModel.h"
#import "RegionModel.h"

NS_ASSUME_NONNULL_BEGIN

//num:0表示（省市区）第一次确定
//num:1表示（街道）第二次确定

typedef NS_ENUM(NSInteger,QSPickerType) {
    QSPickerTypeProvince = 0,
    QSPickerTypeStreet = 1
};

typedef void(^CompleteBlock)(NSString *, NSInteger num, RegionModel *region);


@interface PickerViewController : UIViewController
+ (instancetype)cityPickerController;
- (void)showProvincePickerVC:(CompleteBlock)completeBlock;
- (void)showStreetPickerVC:(CompleteBlock)completeBlock streetArray:(NSArray *)streetArray;
@end

NS_ASSUME_NONNULL_END
