//
//  CoderModel.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/28.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "CoderModel.h"
#import <objc/runtime.h>

@interface CoderModel ()
{
    NSInteger myAge;
}
@property (nonatomic, copy) NSString *sex;
@end

@implementation CoderModel
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age sex:(NSString *)sex {
    self = [super init];
    if (self) {
        self.name = name;
        self.sex = sex;
        myAge = age;
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *varsArray = [self getAllVar];
    [varsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        NSArray *varsArray = [self getAllVar];
        [varsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}

- (NSArray *)getAllVar {
    NSMutableArray *varsArray = @[].mutableCopy;
    int count;
    Ivar *varList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        char *charName = ivar_getName(varList[i]);
        NSString *varName = [NSString stringWithCString:charName encoding:NSUTF8StringEncoding];
        //property的成员变量名默认是：_+属性变量名
        //其实去不去掉"_"都没有关系，因为kvc有自动匹配机制，先找key,找不到就找_key
        if ([varName hasPrefix:@"_"]) {
            [varsArray addObject:[varName substringFromIndex:1]];
        } else {
            [varsArray addObject:varName];
        }
    }
    free(varList);
    return varsArray;
}

- (NSString *)debugDescription {
    NSDictionary *info = @{@"name":self.name,
                           @"myAge":@(myAge),
                           @"sex":self.sex
                           };
    
    if (![NSJSONSerialization isValidJSONObject:info]) {
        NSLog(@"不能转化...");
        return nil;
    } else {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    }
}

- (NSString *)serialJsonToStr {
    NSDictionary *info = @{@"name":self.name,
                           @"myAge":@(myAge),
                           @"sex":self.sex
                           };
    
    if (![NSJSONSerialization isValidJSONObject:info]) {
        NSLog(@"不能转化...");
        return nil;
    } else {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    }
}

- (NSDictionary *)dataToJson {
    NSError *error;
    NSString *dataStr = @"{'name':'lose'}";
    NSData *dataResult = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dataResult options:NSJSONReadingMutableContainers error:&error];
    return dict;
}

@end
