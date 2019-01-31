//
//  RuntimePerson6methodSign.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/31.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson6methodSign.h"
#import "RuntimePerson5resolveInstance.h"

@implementation RuntimePerson6methodSign
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([@"sing" isEqualToString:NSStringFromSelector(aSelector)]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}


#pragma mark - /修改方法的调用对象
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];

    RuntimePerson5resolveInstance *p5 = [[RuntimePerson5resolveInstance alloc] init];
    if ([p5 respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p5];
    }
}


//#pragma mark - 修改方法的实现
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    [anInvocation setSelector:@selector(dance)];
//    [anInvocation invokeWithTarget:self];
//}
//
//- (void)dance {
//
//}


@end
