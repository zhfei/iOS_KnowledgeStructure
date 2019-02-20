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

//num:0表示第一次确定
//num:1表示第二次确定
typedef void(^CompleteBlock)(NSString *, NSInteger num);

@interface PickerViewController : UIViewController
+ (instancetype)showPickerVC:(CompleteBlock)completeBlock ;
//- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
