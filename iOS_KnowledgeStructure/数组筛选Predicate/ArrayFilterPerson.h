//
//  ArrayFilterPerson.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/15.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArrayFilterPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)person:(NSString *)name age:(NSInteger)age;

+ (NSArray *)dataSource;
@end

NS_ASSUME_NONNULL_END
