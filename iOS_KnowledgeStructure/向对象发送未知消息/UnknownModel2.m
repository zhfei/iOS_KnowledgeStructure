//
//  UnknownModel2.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/27.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "UnknownModel2.h"

@implementation UnknownModel2
- (void)gogogo{
    NSLog(@"lalalalala---%@",NSStringFromSelector(_cmd));
    
    Class agogogoClass = [self class];
    NSLog(@"showSuper---%@",agogogoClass);
}
    
- (void)showSuper{
    Class aClass = [super class];
    NSLog(@"showSuper---%@",aClass);
}
@end
