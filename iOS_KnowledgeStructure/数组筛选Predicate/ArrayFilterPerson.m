//
//  ArrayFilterPerson.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/15.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ArrayFilterPerson.h"

@implementation ArrayFilterPerson
+ (instancetype)person:(NSString *)name age:(NSInteger)age {
    ArrayFilterPerson *p = [ArrayFilterPerson new];
    p.name = name;
    p.age = age;
    return p;
}

@end
