//
//  UnionPerson.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/19.
//  Copyright © 2020年 zhf. All rights reserved.
//
/*
 共用体：里面所有的成员变量，不管有多少个变量类型，整个共用体的最大内存空间就是 占据最大内存空间的变量类型
 下面这个共用体的总共内存空间大小是4个字节， 即：一个int类型所占的内存大小。
 
 union {
     int year;
     int month;
     int day;
 };
 */




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnionPerson : NSObject


@end

NS_ASSUME_NONNULL_END
