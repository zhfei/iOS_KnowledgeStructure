//
//  CoreDataHelper.h
//  GooseEgg
//
//  Created by zhoufei on 2019/4/4.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject
//生成上下文、关联数据库
- (void)createSqlite;

//增
- (void)saveObject;
//删
- (void)deleteObject;
//改
- (void)udpateObject;
//查
- (void)fetchObject;
@end

NS_ASSUME_NONNULL_END
