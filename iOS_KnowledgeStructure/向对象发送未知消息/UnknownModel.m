//
//  UnknownModel.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/26.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "UnknownModel.h"

@implementation UnknownModel
//1
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"1---%@",NSStringFromSelector(sel));
    NSLog(@"1---%@",NSStringFromSelector(_cmd));
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"1---%@",NSStringFromSelector(sel));
    NSLog(@"1---%@",NSStringFromSelector(_cmd));
    return NO;
}

//2
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"2---%@",NSStringFromSelector(aSelector));
    NSLog(@"2---%@",NSStringFromSelector(_cmd));
    return nil;
}
//3
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"3---%@",NSStringFromSelector(_cmd));
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"3---%@",NSStringFromSelector(aSelector));
    NSLog(@"3---%@",NSStringFromSelector(_cmd));
    return nil;
}


@end
