//
//  RuntimeApply1.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimeApply1.h"

//#if TARGET_IPHONE_SIMULATOR
//#import <objc/objc-runtime.h>
//#else
//#import <objc/runtime.h>
//#import <objc/message.h>
//#endif
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RuntimeApply1

- (instancetype)init {
    if (self = [super init]) {
        
        Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
        class_addIvar(Person, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        class_addIvar(Person, "_age", sizeof(int), sizeof(int), @encode(int));
        //注册方法
        SEL say = sel_registerName("say:");
        class_addMethod(Person, say, (IMP)sayFunction, "v@:@");
        //注册类
        objc_registerClassPair(Person);
        
        id person1 = [[Person alloc] init];
        [person1 setValue:@"苍老师" forKey:@"name"];
        //设置属性值
        Ivar ageIvar = class_getInstanceVariable(Person, "_age");
        object_setIvar(person1, ageIvar, @18);
        
        ((void(*)(id,SEL,id))objc_msgSend)(person1, say, @"大家好");
        
        person1 = nil;
        objc_disposeClassPair(Person);
//        // 动态创建对象 创建一个Person 继承自 NSObject类
//        Class People = objc_allocateClassPair([NSObject class], "Person", 0);
//
//        // 为该类添加NSString *_name成员变量
//        class_addIvar(People, "_name", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
//        // 为该类添加int _age成员变量
//        class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
//
//        // 注册方法名为say的方法
//        SEL s = sel_registerName("say:");
//        // 为该类增加名为say的方法
//        class_addMethod(People, s, (IMP)sayFunction, "v@:@");
//
//        // 注册该类
//        objc_registerClassPair(People);
//
//        // 创建一个类的实例
//        id peopleInstance = [[People alloc] init];
//
//        // KVC 动态改变 对象peopleInstance 中的实例变量
//        [peopleInstance setValue:@"苍老师" forKey:@"name"];
//
//        // 从类中获取成员变量Ivar
//        Ivar ageIvar = class_getInstanceVariable(People, "_age");
//        // 为peopleInstance的成员变量赋值
//        object_setIvar(peopleInstance, ageIvar, @18);
//
//        // 调用 peopleInstance 对象中的 s 方法选择器对于的方法
//        // objc_msgSend(peopleInstance, s, @"大家好!"); // 这样写也可以，请看我博客说明
//        ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");
//
//        peopleInstance = nil; //当People类或者它的子类的实例还存在，则不能调用objc_disposeClassPair这个方法；因此这里要先销毁实例对象后才能销毁类；
//
//        // 销毁类
//        objc_disposeClassPair(People);

        
    }
    return self;
}

void sayFunction(id self, SEL _cmd, id some) {
    Ivar ivar = class_getInstanceVariable([self class], "_age");
    id obj = object_getIvar(self, ivar);
    
    id obj2 = [self valueForKey:@"name"];
    NSLog(@"%@岁的%@说：%@",obj, obj2, some);
}

@end
