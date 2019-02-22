//
//  HybirdViewController2.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/22.
//  Copyright © 2019年 zhf. All rights reserved.
//
//OC调用JS方法：
//[webView evaluateJavaScript:@"iOSCallJsAlert()" completionHandler:nil]

//JS调用OC方法：
//function iOSCallJsAlert()
//{
//    alert('弹个窗，再调用iOS端的JS_Function_Name');
//    window.webkit.messageHandlers.JS_Function_Name.postMessage({body: 'paramters'});
//}

#import "HybirdViewController2.h"
#import <WebKit/WebKit.h>

NSString *const My_NativeMethod1 = @"My_NativeMethod1";

@interface HybirdViewController2 ()<WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HybirdViewController2
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Getter, Setter
- (WKWebView *)webView {
    if (!_webView) {
        WKUserContentController *userContent = [[WKUserContentController alloc] init];
        //JS呼叫OC时，方法会走到此delegate
        [userContent addScriptMessageHandler:self name:My_NativeMethod1];
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = userContent;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    }
    return _webView;
}
#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)addUI {
    
}

- (void)setupUI {
    
}

- (void)setupLayout {
    
}

- (void)setupData {
    
}



#pragma mark - Delegate
#pragma mark navigationDelegate
////`WKWebView`中的`navigationDelegate`协议可以监听加载网页的周期和结果。
////判断链接是否允许跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction     decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
//
//
////拿到响应后决定是否允许跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
//
//
////链接开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//
//
////收到服务器重定向时调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//
//
////加载错误时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//
//
////当内容开始到达主帧时被调用（即将完成）
//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
//
//
////加载完成
//- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
//
//
////在提交的主帧中发生错误时调用
//- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//
//
//
////当webView需要响应身份验证时调用(如需验证服务器证书)
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge    completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *_Nullable   credential))completionHandler;
//
//
////当webView的web内容进程被终止时调用。(iOS 9.0之后)
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));



#pragma mark WKUIDelegate
//在JS端调用alert函数时，会触发此代理方法。JS端调用alert时所传的数据可以通过message拿到。在原生得到结果后，需要回调JS，是通过completionHandler回调。
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"message = %@",message);
}


//JS端调用confirm函数时，会触发此方法，通过message可以拿到JS端所传的数据，在iOS端显示原生alert得到YES/NO后，通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    NSLog(@"message = %@",message);
}


//JS端调用prompt函数时，会触发此方法,要求输入一段文本,在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
     {
         textField.textColor = [UIColor redColor];
     }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          completionHandler([[alert.textFields lastObject] text]);
                      }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark WKScriptMessageHandler
//JS调用OC方法
//function iOSCallJsAlert()
//{
//    alert('弹个窗，再调用iOS端的JS_Function_Name');
//    window.webkit.messageHandlers.JS_Function_Name.postMessage({body: 'paramters'});
//}
//OC收到JS的调用，
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:My_NativeMethod1]) {
        //收到js调用
    }
    NSLog(@"JS调iOS  name : %@    body : %@",message.name,message.body);
}


#pragma mark - NSCopying

#pragma mark - NSObject

@end
