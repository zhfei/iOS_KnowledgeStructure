//
//  Student+CoreDataProperties.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/4.
//  Copyright © 2019年 zhf. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic age;
@dynamic height;
@dynamic name;
@dynamic sex;

@end
