//
//  RuntimePerson5resolveInstance.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/31.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson5resolveInstance.h"
#import <objc/runtime.h>

@implementation RuntimePerson5resolveInstance
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([@"sing" isEqualToString:NSStringFromSelector(sel)]) {
        class_addMethod(self, sel, (IMP)otherSing, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}


#pragma mark - 动态方法实现
void otherSing(id self, SEL _cmd)
{
    // implementation ....
}



@end
