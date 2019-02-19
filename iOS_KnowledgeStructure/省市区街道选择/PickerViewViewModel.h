//
//  PickerViewViewModel.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVAreaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickerViewViewModel : NSObject
+ (NSArray <PVAreaModel *> *)dataSource;
@end

NS_ASSUME_NONNULL_END
