//
//  CoreDataHelper2.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/5/7.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CoreDataHelper2.h"
#import <CoreData/CoreData.h>

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

- (instancetype)init
{
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


@end
