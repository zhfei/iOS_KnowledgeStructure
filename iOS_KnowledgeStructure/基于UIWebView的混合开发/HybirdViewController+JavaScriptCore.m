//
//  HybirdViewController+JavaScriptCore.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/21.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "HybirdViewController+JavaScriptCore.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation HybirdViewController (JavaScriptCore)
- (void)javaScriptCoreTest {
    [self javaScriptCoreTest0];
    [self javaScriptCoreTest1];
    [self javaScriptCoreTest2];
}
//[content evaluateScript:jsStr];上下文调用，目的把js字符串注入到上下文环境中
//[value2 callWithArguments:@[@(6)]];Value调用，执行js中的函数，js中所有的东西都是JSValue,包括：int ,array, func
- (void)javaScriptCoreTest0 {
    JSContext *content = [[JSContext alloc] init];
    NSString *jsStr = @"2 + 2";
    JSValue *value1 = [content evaluateScript:jsStr];
    NSLog(@"%@--%d",jsStr,[value1 toInt32]);
    //2
    NSString *jsStr2 = @"var factorial = function(n) {"
                            "if (n < 0) {"
                                "return;"
                            "};"
                            "if (n == 1) {"
                                "return 1;"
                            "};"
                            "return n*factorial(n-1);"
                        "};";
    [content evaluateScript:jsStr2];
    JSValue *value2 = content[@"factorial"];
    JSValue *res2 = [value2 callWithArguments:@[@(6)]];
    NSLog(@"res2:%d",[res2 toInt32]);
}

- (void)javaScriptCoreTest1 {
    
}

- (void)javaScriptCoreTest2 {
    
}



@end
