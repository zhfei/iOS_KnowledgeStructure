//
//  HybirdViewController+JavaScriptCore.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/21.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "HybirdViewController+JavaScriptCore.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyPoint.h"

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

//js与oc交互
//block:将一个方法注入js上下文，注意block中不能有JSValue,JSContext。不然会循环引用
- (void)javaScriptCoreTest1 {
    JSContext *context = [[JSContext alloc] init];
    context[@"makeNSColor"] = ^(NSDictionary *rgb) {
        CGFloat r = [rgb[@"red"] floatValue];
        CGFloat g = [rgb[@"green"] floatValue];
        CGFloat b = [rgb[@"blue"] floatValue];
        UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        return color;
    };
    
    NSString *jsStr2 = @"var colorFromWord = function(word) {"
                        "var colorMap = {red:{r:0.1,g:0.2,b:0.3}]}"
                        "var v = colorMap[word]"
                        "var color = makeNSColor(v)"
                        "};";
    [context evaluateScript:jsStr2];
    JSValue *value2 = context[@"colorFromWord"];
    [value2 callWithArguments:@[@"red"]];
}

//遵守了JSExport协议的对象，就可以直接将对象传递给JavaScriptCore,js就可以调用自己的对象一样调用OC的对象了
- (void)javaScriptCoreTest2 {
    JSContext *context = [[JSContext alloc] init];
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"exception:%@",exception);
    };
    
    MyPoint *point = [MyPoint makePointX:10 y:20];
    context[@"point"] = point;
    NSString *js = @"point.x";
    JSValue *value1 = [context evaluateScript:js];
    NSLog(@"point.x: %d",[value1 toInt32]);
}

//因为js的加载时间不好把握，当有多级页面跳转时，可能出现拿到的JSContext无法调用js
- (void)javaScriptCoreTest3 {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
}

@end
