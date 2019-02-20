//
//  RegionModel.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/20.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegionModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<RegionModel *> *children;
@end

NS_ASSUME_NONNULL_END
