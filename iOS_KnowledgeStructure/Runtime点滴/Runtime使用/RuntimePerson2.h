//
//  RuntimePerson2.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimePerson2 : NSObject
{
    NSString *_occupation;//职业
    NSString *_nationality;//国家
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end

NS_ASSUME_NONNULL_END
