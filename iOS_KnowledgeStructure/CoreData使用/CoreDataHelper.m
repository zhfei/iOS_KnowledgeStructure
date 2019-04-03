//
//  CoreDataHelper.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/2.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>

@interface CoreDataHelper ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation CoreDataHelper
//获取管理对象上下文
- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
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
        
        _managedObjectContext = context;
    }
    return _managedObjectContext;
}

//持久化到本地
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

//增
- (void)insertObject {
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    //为一个key值进行赋值
    [entity setValue:@"newName" forKey:@"name"];
    
    //更新到数据库
    NSError *error;
    BOOL success = [self.managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"数据库更新失败" format:@"%@",[error description]];
    }
}
//删
- (void)deleteObject {
    
}
//改
//查
- (NSArray *)requestObject {
    //创建请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置需要查询的实体描述
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    request.entity = entityDes;
    //设置排序描述
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    request.sortDescriptors = @[sort1];
    //设置过滤条件
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"age<%d",30];
    request.predicate = predice;
    //执行查询
    NSError *error;
    NSArray *objcs = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return objcs;
}


@end
