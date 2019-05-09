//
//  Department+CoreDataProperties.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/5/8.
//  Copyright © 2019年 zhf. All rights reserved.
//
//

#import "Department+CoreDataProperties.h"

@implementation Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Department"];
}

@dynamic createDate;
@dynamic departName;
@dynamic employee;

@end
