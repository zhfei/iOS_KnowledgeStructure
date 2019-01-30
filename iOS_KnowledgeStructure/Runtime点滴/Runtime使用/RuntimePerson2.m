//
//  RuntimePerson2.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson2.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RuntimePerson2
- (NSDictionary *)allProperties {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; i++) {
        objc_property_t pro = properties[i];
        NSString *proName = [NSString stringWithCString:property_getName(pro) encoding:NSUTF8StringEncoding];
        id obj = [self valueForKey:proName];
        if (obj) {
            dictM[proName] = obj;
        } else {
            dictM[proName] = @"未知";
        }
    }
    free(properties);
    return dictM;
}
- (NSDictionary *)allIvars {
    unsigned int count;
    Ivar *vars = class_copyIvarList([self class], &count);
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];

    for (int i = 0; i < count; i++) {
        Ivar var = vars[i];
        NSString *varName = [NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding];
        id obj = [self valueForKey:varName];
        if (obj) {
            dictM[varName] = obj;
        } else {
            dictM[varName] = @"未知";
        }
        
    }
    free(vars);
    return dictM;

}
- (NSDictionary *)allMethods {
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        const char * selName =  sel_getName(method_getName(method));
        NSString *methodName = [NSString stringWithCString:selName encoding:NSUTF8StringEncoding];

        unsigned int num = method_getNumberOfArguments(method);
        dictM[methodName] = @(num-2);
    }
    free(methods);
    
    return dictM;
}
@end
