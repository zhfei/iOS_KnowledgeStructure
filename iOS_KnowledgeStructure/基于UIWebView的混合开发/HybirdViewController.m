//
//  HybirdViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/1.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "HybirdViewController.h"
#import "HybirdViewController+delegate.h"
#import <GRMustacheTemplate.h>
#import "WebViewJavascriptBridge.h"
#import "HybirdViewController+JavaScriptCore.h"
#import "HybirdViewController2.h"

@interface HybirdViewController ()
@property WebViewJavascriptBridge* bridge;


@end

@implementation HybirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    
    //WebViewJavascriptBridge原理
    //1.OC和JS各保留一份Bridg对象，里面保存着requestID, callbackID
    //2.OC调用JS: OC通过调用JS中的Bridg对象，找到具体的方法然后调用。
    //3.JS调用OC：JS是通过iframe的src触发代理，调用OC
    
    //OC注册方法给JS调用
    [self.bridge registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        responseCallback(data);
    }];
    [self.bridge callHandler:@"JS Echo" data:nil responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
    [self.bridge registerHandler:@"getScreenHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([NSNumber numberWithInt:[UIScreen mainScreen].bounds.size.height]);
        NSLog(@"收到JS的调用！");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self javaScriptCoreTest];
}

- (IBAction)btnAction:(UIButton *)sender {
    id result = [self.webView stringByEvaluatingJavaScriptFromString:@"htmlSum(1,2)"];
    NSLog(@"%@",result);
    id result2 = [self.webView stringByEvaluatingJavaScriptFromString:@"loadURL('gap://alert')"];
    NSLog(@"%@",result2);
    
    [self.bridge callHandler:@"JS Echo" data:@"byby" responseCallback:^(id responseData) {
        NSLog(@"%@",responseData);
    }];
}

- (IBAction)loadAction:(UIButton *)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:request];
}

- (IBAction)localAction:(UIButton *)sender {
    [self.webView loadHTMLString:[self htmlString] baseURL:nil];
    
//    HybirdViewController2 *hc2 = [HybirdViewController2 new];
//    [self.navigationController pushViewController:hc2 animated:YES];
}

- (NSString *)htmlString {
//    NSString *str = @"<html>"
//    "<head>"
//    "<meta charset='UTF-8'>"
//    "</head>"
//    "<body>"
//    "<h1>%@</h1>"
//    "<p>%@</p>"
//    "</body>"
//    "</html>";
//    return [NSString stringWithFormat:str,[UIDevice currentDevice].model,[UIDevice currentDevice].systemName];
    
    NSString *fileName = @"template.html";
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
    NSString *templete = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    
    NSDictionary *dict = @{@"name":@"hello", @"content":@"wooooood"};
    NSString *content = [GRMustacheTemplate renderObject:dict fromString:templete error:nil];
    
    
    return content;
}

@end
