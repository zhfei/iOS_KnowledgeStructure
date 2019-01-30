//
//  RuntimePerson4jsonDict.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/31.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimePerson4jsonDict : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

// 生成model
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// 转换成字典
- (NSDictionary *)covertToDictionary;
@end

NS_ASSUME_NONNULL_END
