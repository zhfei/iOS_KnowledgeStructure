//
//  RuntimeBase.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimeBase.h"
#import <objc/runtime.h>

@implementation RuntimeBase
//
//
//typedef struct objc_class *Class;
//
//struct objc_class {
//    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
//
//#if !__OBJC2__
//    Class _Nullable super_class                              OBJC2_UNAVAILABLE;
//    const char * _Nonnull name                               OBJC2_UNAVAILABLE;
//    long version                                             OBJC2_UNAVAILABLE;
//    long info                                                OBJC2_UNAVAILABLE;
//    long instance_size                                       OBJC2_UNAVAILABLE;
//    struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE;
//    struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;
//    struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE;
//    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
//#endif
//
//} OBJC2_UNAVAILABLE;
//
//
//// 成员变量
//struct objc_ivar {
//    // 成员变量名
//    char * _Nullable ivar_name                               OBJC2_UNAVAILABLE;
//    // 成员变量类型
//    char * _Nullable ivar_type                               OBJC2_UNAVAILABLE;
//    // 成员变量相对于对象指针的偏移量
//    int ivar_offset                                          OBJC2_UNAVAILABLE;
//#ifdef __LP64__
//    int space                                                OBJC2_UNAVAILABLE;
//#endif
//};
//
//// 方法对象
//struct objc_method {
//    SEL _Nonnull method_name                                 OBJC2_UNAVAILABLE;
//    char * _Nullable method_types                            OBJC2_UNAVAILABLE;
//    IMP _Nonnull method_imp                                  OBJC2_UNAVAILABLE;
//};                                                            OBJC2_UNAVAILABLE;
//
//// 缓存对象
//struct objc_cache {
//    //缓存数组总长度
//    unsigned int mask /* total = mask + 1 */                 OBJC2_UNAVAILABLE;
//    //实际使用的长度
//    unsigned int occupied                                    OBJC2_UNAVAILABLE;
//    Method _Nullable buckets[1]                              OBJC2_UNAVAILABLE;
//};
//
//// 对象分类
//struct objc_category {
//    // 分类名称
//    char * _Nonnull category_name                            OBJC2_UNAVAILABLE;
//    // 分类的类名称
//    char * _Nonnull class_name                               OBJC2_UNAVAILABLE;
//    // 实例方法列表
//    struct objc_method_list * _Nullable instance_methods     OBJC2_UNAVAILABLE;
//    // 类方法列表
//    struct objc_method_list * _Nullable class_methods        OBJC2_UNAVAILABLE;
//    // 协议方法列表
//    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
//};
//
//
//
//struct objc_object {
//    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
//};
//
///// A pointer to an instance of a class.
//typedef struct objc_object *id;

















@end
