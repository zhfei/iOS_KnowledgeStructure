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
- (void)setupCoreData {
    //加载模型文件
    NSManagedObjectModel *modelFile = [NSManagedObjectModel mergedModelFromBundles:nil];

    //通过模型文件，构建持久化中介者
    NSPersistentStoreCoordinator *coor = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modelFile];
    
    //构建sqlite数据库路径
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL *url = [NSURL URLWithString:[documentDir stringByAppendingPathComponent:@"coreData.data"]];
    
}


@end
