//
//  Person.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
- (void)instanceRun;
+ (void)methodRun;
@property(nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
