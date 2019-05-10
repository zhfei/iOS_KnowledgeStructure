//
//  CoreDataHelper2.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/5/7.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CoreDataHelper2.h"
#import <CoreData/CoreData.h>
#import "Department+CoreDataClass.h"

static NSString * const kMapDepartment = @"Department";

static CoreDataHelper2 *sharedCoreDataHelper;

@interface CoreDataHelper2 ()
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation CoreDataHelper2
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoreDataHelper = [super allocWithZone:zone];
    });
    return sharedCoreDataHelper;
}

+ (instancetype)sharedCoreDataHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoreDataHelper = [[self alloc] init];
    });
    return sharedCoreDataHelper;
}

- (id)copyWithZone:(NSZone *)zone {
    return sharedCoreDataHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupData];
    }
    return self;
}

- (void)setupData {
    //创建托管对象上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.context = context;
    
    NSURL *momURL = [[NSBundle mainBundle] URLForResource:@"GooseEgg" withExtension:@"momd"];
    //托管对象类文件
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    //持久化存储中介者
    NSPersistentStoreCoordinator *coor = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    //创建并关联sqlite数据库文件
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dataPath = [documentDir stringByAppendingFormat:@"/%@.sqlite",@"Company"];
    [coor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL URLWithString:dataPath] options:nil error:nil];
    context.persistentStoreCoordinator = coor;
}

- (void)update2Location {
    NSError *error = NULL;
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    if (error) {
        NSLog(@"error:%@",error.description);
    }

}

- (void)insertEntity:(NSString *)name {
    Department *department = [NSEntityDescription insertNewObjectForEntityForName:kMapDepartment inManagedObjectContext:self.context];
    department.createDate = [NSDate date];
    department.departName = @"WorkRoom";
    
    [self update2Location];
}

- (void)deleteEntity {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kMapDepartment];
    
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"departName == %@",@"WorkRoom"];
    request.predicate = predice;
    
    NSArray * departments = [self.context executeFetchRequest:request error:nil];
    __weak typeof(self)weakSelf=self;
    [departments enumerateObjectsUsingBlock:^(Department * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.context deleteObject:obj];
    }];

    [self update2Location];
}

- (void)updateEntity {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kMapDepartment];
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"departName == %@",@"WorkRoom"];
    request.predicate = predice;
    
    NSArray *departments = [self.context executeFetchRequest:request error:nil];
    [departments enumerateObjectsUsingBlock:^(Department * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.createDate = [NSDate date];
    }];
    
    [self update2Location];
}

- (NSArray *)fetchEntities {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kMapDepartment];
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"departName == %@",@"WorkRoom"];
    request.predicate = predice;
    
    NSArray *departments = [self.context executeFetchRequest:request error:nil];
    return departments;
}

@end
