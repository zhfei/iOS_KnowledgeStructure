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

@interface PickerViewController : UIViewController
@property (nonatomic, strong) NSArray <PVAreaModel *>* dataSource;
@property (nonatomic, strong) NSArray <RegionModel *>* dataSource2;
@end

NS_ASSUME_NONNULL_END
