//
//  ArrayFiltrateViewModel.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/15.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ArrayFiltrateViewModel.h"
#import "ArrayFilterPerson.h"

@implementation ArrayFiltrateViewModel
+ (NSArray *)dataSource {
    ArrayFilterPerson *p = [ArrayFilterPerson person:@"jack" age:18];
    ArrayFilterPerson *p1 = [ArrayFilterPerson person:@"tom" age:36];
    return @[p,p1];
}

@end
