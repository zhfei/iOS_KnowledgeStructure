//
//  RuntimePerson3Coding.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimePerson3Coding : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;
@end

NS_ASSUME_NONNULL_END
