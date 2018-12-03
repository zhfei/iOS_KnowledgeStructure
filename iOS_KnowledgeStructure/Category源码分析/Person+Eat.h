//
//  Person+Eat.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Eat)
@property(nonatomic, assign) int age;
- (void)instanceEat;
+ (void)methodEat;
@end

NS_ASSUME_NONNULL_END
