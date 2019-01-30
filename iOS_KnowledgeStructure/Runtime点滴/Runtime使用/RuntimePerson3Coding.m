//
//  RuntimePerson3Coding.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson3Coding.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RuntimePerson3Coding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count;
        Ivar *vars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar var = vars[i];
            NSString *varName = [NSString stringWithUTF8String:ivar_getName(var)];
            id obj = [aDecoder decodeObjectForKey:varName];
            [self setValue:obj forKey:varName];
        }
        free(vars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = vars[i];
        NSString *varName = [NSString stringWithUTF8String:ivar_getName(var)];
        id obj = [self valueForKey:varName];
        [aCoder encodeObject:obj forKey:varName];
    }
    free(vars);
}

@end
