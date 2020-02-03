//
//  VariableParamFunction.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/2/3.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import "VariableParamFunction.h"

@implementation VariableParamFunction

- (void)demoSelector:(NSString *)fmt param:(NSString *)param1, ... NS_REQUIRES_NIL_TERMINATION{
    //1.定义可变参数列表
    va_list vpList;
    
    //2.初始化可变参数列表vpList
    //param1：最后一个确定参数(第一个可变参数的前一个)。
    //vpList:指向下一个待读的参数
    va_start(vpList, param1);
    NSString *nextParam = nil;
    
    do {
        //3.读取待读的参数，并将vpList移动到下一个参数
        //NSString *: 下一个待读参数的类型
        //NSLog: 也是基于va_arg来实现的，所以需要在fmt中写名类型，不然在参数读取后，内存偏移时，偏移多少位无法确定。
        nextParam = va_arg(vpList, NSString *);
        NSLog(@"%@  -- %p",nextParam, nextParam);
    } while(nextParam);
    
    //4.关闭可读参数链表
    //vpList设置成NULL
    va_end(vpList);
}

@end
