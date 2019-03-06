//
//  RegionModel.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/20.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RegionModel.h"
#import <NSObject+YYModel.h>

@implementation RegionModel
- (void)setChildren:(NSMutableArray<RegionModel *> *)children {
    if ([[children firstObject] isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:[children count]];
        [children enumerateObjectsUsingBlock:^(RegionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RegionModel *model = [RegionModel yy_modelWithDictionary:obj];
            [arrayM addObject:model];
        }];
        _children = arrayM;
    } else {
        _children = children;
    }
}


@end
