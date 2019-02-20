//
//  PickerViewViewModel.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "PickerViewViewModel.h"
#import <YYKit/NSObject+YYModel.h>

@implementation PickerViewViewModel
+ (NSArray <PVAreaModel *> *)dataSource {
    NSDictionary *dict = [self readLocalPlistFileWithName:@"list"];
    NSMutableArray *arrayM = @[].mutableCopy;
    [[dict allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PVAreaModel *pr;
        if ([dict[obj] isKindOfClass:[NSDictionary class]]) {
            pr = [PVProvince modelWithInfo:dict[obj]];
        } else {
            pr = [PVCity modelWithInfo:dict[obj]];
        }
        pr.location = obj;
        [arrayM addObject:pr];
    }];
    return arrayM;
}

+ (NSDictionary *)readLocalJsonFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

+ (NSDictionary *)readLocalPlistFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];;
}





+ (NSArray *)dataSource2 {
    NSArray *cities = [self readLocalJsonFileWithName:@"cities"];
    NSMutableArray *arrayM = @[].mutableCopy;
    [cities enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RegionModel *model = [RegionModel modelWithDictionary:obj];
        [arrayM addObject:model];
    }];
    NSLog(@"arrayM:%@",arrayM);
    return arrayM;
}
@end
