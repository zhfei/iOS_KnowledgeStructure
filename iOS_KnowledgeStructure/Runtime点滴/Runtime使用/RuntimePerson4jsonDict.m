//
//  RuntimePerson4jsonDict.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/31.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson4jsonDict.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RuntimePerson4jsonDict
// 生成model
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSArray *allKeys =  dictionary.allKeys;
        for (NSString *key in allKeys) {
            SEL setter = [self propertySetterByKey:key];
            ((void(*)(id,SEL,id))objc_msgSend)(self, setter, dictionary[key]);
        }
    }
    return self;
}

// 转换成字典
- (NSDictionary *)covertToDictionary {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t pro = properties[i];
        NSString *proName = [NSString stringWithUTF8String:property_getName(pro)];
        SEL getter = [self propertyGetterByKey:proName];
        id obj = ((id(*)(id,SEL))objc_msgSend)(self, getter);
        if (obj) {
            dictM[proName] = obj;
        } else {
            dictM[proName] = @"unknow...";
        }
        
    }
    free(properties);
    return dictM;
}

// 生成setter方法
- (SEL)propertySetterByKey:(NSString *)key
{
    // 首字母大写，你懂得
    NSString *propertySetterName = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
    
    SEL setter = NSSelectorFromString(propertySetterName);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

// 生成getter方法
- (SEL)propertyGetterByKey:(NSString *)key
{
    SEL getter = NSSelectorFromString(key);
    if ([self respondsToSelector:getter]) {
        return getter;
    }
    return nil;
}


@end
