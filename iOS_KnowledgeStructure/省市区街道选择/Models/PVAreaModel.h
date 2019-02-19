//
//  PVAreaModel.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PVAreaModel : NSObject
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy, readonly) NSString *num;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray *datas;

+ (instancetype)modelWithInfo:(id)info;
@end

//区
@interface PVDistrict : PVAreaModel
@end

//市
@interface PVCity : PVAreaModel
@property (nonatomic, strong) NSArray<PVDistrict *> *districts;
@end

//省
@interface PVProvince : PVAreaModel
@property (nonatomic, strong) NSArray<PVCity *> *cities;
@end


NS_ASSUME_NONNULL_END
