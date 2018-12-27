//
//  UnknownModel.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/26.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "UnknownModel.h"
#import "UnknownModel2.h"
#import <objc/runtime.h>

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
//3.最后一步，返回方法签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"3---%@",NSStringFromSelector(aSelector));
    NSLog(@"3---%@",NSStringFromSelector(_cmd));
    if ([NSStringFromSelector(aSelector) isEqualToString:@"gogogo"]) {
        return [[UnknownModel2 new] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}
//3.1处理返回的方法签名
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"4---%@",NSStringFromSelector(_cmd));
    NSLog(@"4-最后一步--%@",anInvocation);
    if ([NSStringFromSelector(anInvocation.selector) isEqualToString:@"gogogo"]) {
        [anInvocation invokeWithTarget:[UnknownModel2 new]];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

/*
 2018-12-27 00:14:00.469445+0800 iOS_KnowledgeStructure[7940:110114] 1---gogogo
 2018-12-27 00:14:00.469613+0800 iOS_KnowledgeStructure[7940:110114] 1---resolveInstanceMethod:
 2018-12-27 00:14:00.469765+0800 iOS_KnowledgeStructure[7940:110114] 2---gogogo
 2018-12-27 00:14:00.469873+0800 iOS_KnowledgeStructure[7940:110114] 2---forwardingTargetForSelector:
 2018-12-27 00:14:00.469978+0800 iOS_KnowledgeStructure[7940:110114] 3---gogogo
 2018-12-27 00:14:00.470097+0800 iOS_KnowledgeStructure[7940:110114] 3---methodSignatureForSelector:
 2018-12-27 00:14:00.470247+0800 iOS_KnowledgeStructure[7940:110114] 1---_forwardStackInvocation:
 2018-12-27 00:14:00.470355+0800 iOS_KnowledgeStructure[7940:110114] 1---resolveInstanceMethod:
 2018-12-27 00:14:00.470765+0800 iOS_KnowledgeStructure[7940:110114] 4---forwardInvocation:
 2018-12-27 00:14:00.471367+0800 iOS_KnowledgeStructure[7940:110114] 4-最后一步--<NSInvocation: 0x600002442000>
 2018-12-27 00:14:00.471969+0800 iOS_KnowledgeStructure[7940:110114] lalalalala---gogogo
 */

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}


@end
