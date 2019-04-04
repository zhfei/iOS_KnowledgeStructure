//
//  CoreDataHelper.m
//  GooseEgg
//
//  Created by zhoufei on 2019/4/4.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>
#import "Student+CoreDataClass.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation CoreDataHelper
- (void)createSqlite {
    //1.创建模型对象
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GooseEgg" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //2.创建持久化存储中介者
    NSPersistentStoreCoordinator *coor = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *sqlPath = [documentDir stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库路径:%@",sqlPath);
    NSURL *sqlURL = [NSURL fileURLWithPath:sqlPath isDirectory:NO];
    [NSURL URLWithString:sqlPath];
    
    NSError *error = nil;
//    [coor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlURL options:nil error:&error];
    
    /* 2. 给持久存储调度设置持久存储类型,并给出创建数据库文件的 URL 地址 */
    [coor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlURL options:nil error:nil];
    
    if (error) {
        NSLog(@"添加数据库失败: %@",[error description]);
    } else {
        NSLog(@"添加数据库成功");
    }
    
    //3.创建上下文。保存信息、对数据库操作
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = coor;
    _context = context;
}

//增
- (void)saveObject {
    //根据Entity名称 + NSManagedObjectContext, 从Context中拿到一个NSManagedObject类
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    stu.name = @"jack";
    stu.age = 12;
    stu.height = 150;
    stu.sex = @"男";
    
    //更新到数据库
    NSError *error = nil;
    if ([self.context save:&error]) {
        NSLog(@"数据插入到数据库成功");
    } else {
        NSLog(@"数据插入到数据库失败:%@",[error description]);
    }
}
//删
- (void)deleteObject {
    //创建一个删除请求
    NSFetchRequest *delReq = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //删除条件
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"age>%d",30];
    delReq.predicate = predice;
    //在上下文中删除，并更新到本地
    NSArray *delArray = [self.context executeFetchRequest:delReq error:nil];
    for (Student *stu in delArray) {
        [self.context deleteObject:stu];
    }
    
    NSError *error = nil;
    if ([self.context save:&error]) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败 :%@",[error description]);
    }
}
//改
- (void)udpateObject {
    //创建一个删除请求
    NSFetchRequest *delReq = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //删除条件
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"age==%d",10];
    delReq.predicate = predice;
    //在上下文中删除，并更新到本地
    NSArray *delArray = [self.context executeFetchRequest:delReq error:nil];
    for (Student *stu in delArray) {
        stu.name = @"小学生";
    }
    
    NSError *error = nil;
    if ([self.context save:&error]) {
        NSLog(@"更新数据成功");
    } else {
        NSLog(@"更新数据失败 :%@",[error description]);
    }
}
//查
- (void)fetchObject {
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //排序条件
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    req.sortDescriptors = @[sort1,sort2];
    //查询条件
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"age<%d",18];
    req.predicate = predice;
    //分页
    req.fetchOffset = 0;//从第几页开始显示
    req.fetchLimit = 10;//每页最多多少个数据。
    
    //fire
    NSArray *res = [self.context executeFetchRequest:req error:nil];
    NSLog(@"结果如下: %@",res);
}

@end
