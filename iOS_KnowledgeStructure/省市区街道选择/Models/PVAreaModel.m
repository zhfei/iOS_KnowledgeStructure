//
//  PVAreaModel.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "PVAreaModel.h"

@implementation PVAreaModel
- (NSString *)num {
    return [self.location substringToIndex:6];
}

- (NSString *)name {
    return [self.location substringFromIndex:6];
}
@end

@implementation PVDistrict
+ (instancetype)modelWithInfo:(id)info {
    PVDistrict *dis = [PVDistrict new];
    dis.location = (NSString *)info;
    return dis;
}

- (NSArray *)datas {
    return @[];
}
@end

@implementation PVCity
+ (instancetype)modelWithInfo:(id)info {
    PVCity *dis = [PVCity new];
    NSMutableArray *arrayM = @[].mutableCopy;
    [(NSArray *)info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PVDistrict *city = [PVDistrict modelWithInfo:obj];
        [arrayM addObject:city];
    }];
    dis.districts = arrayM;
    return dis;
}

- (NSArray *)datas {
    return self.districts;
}
@end

@implementation PVProvince
+ (instancetype)modelWithInfo:(id)info {
    PVProvince *dis = [PVProvince new];
    NSMutableArray *arrayM0 = @[].mutableCopy;
    [[(NSDictionary *)info allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PVCity *city = [PVCity modelWithInfo:(NSDictionary *)info[obj]];
        city.location = obj;
        [arrayM0 addObject:city];
    }];
    dis.cities = arrayM0;
    return dis;
}

- (NSArray *)datas {
    return self.cities;
}
@end

