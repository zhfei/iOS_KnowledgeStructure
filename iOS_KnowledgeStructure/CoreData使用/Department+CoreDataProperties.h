//
//  Department+CoreDataProperties.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/5/8.
//  Copyright © 2019年 zhf. All rights reserved.
//
//

#import "Department+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSString *departName;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employee;

@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(Employee *)value;
- (void)removeEmployeeObject:(Employee *)value;
- (void)addEmployee:(NSSet<Employee *> *)values;
- (void)removeEmployee:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
