//
//  CoreDataHelper.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/2.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>

@implementation CoreDataHelper
- (NSManagedObjectContext *)managedObjectContext {
    //加载模型文件
    NSManagedObjectModel *modelFile = [NSManagedObjectModel mergedModelFromBundles:nil];

    //通过模型文件，构建持久化中介者
    NSPersistentStoreCoordinator *coor = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modelFile];
    
    //构建sqlite数据库路径
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL *url = [NSURL URLWithString:[documentDir stringByAppendingPathComponent:@"coreData.data"]];
    
    //添加数据库
    NSError *error = nil;
    NSPersistentStore *store = [coor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"添加数据库失败" format:@"%@",[error description]];
    }
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = coor;
    
    return context;
}

- (void)saveData2DB {
    NSManagedObjectContext *context = [self managedObjectContext];
    //person
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [person setValue:@"jame" forKey:@"name"];
    [person setValue:@(20) forKey:@"age"];
    
    //card
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    [card setValue:@(123) forKey:@"num"];
    
    //建立关系
    [person setValue:card forKey:@"card"];
    
    NSError *error;
    BOOL result = [context save:&error];
    if (!result) {
        [NSException raise:@"数据库访问错误" format:@"%@",[error description]];
    }
}


@end
