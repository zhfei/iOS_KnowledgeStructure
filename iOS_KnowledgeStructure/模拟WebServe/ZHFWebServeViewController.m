//
//  ZHFWebServeViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/5/17.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ZHFWebServeViewController.h"
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebUploader.h>
#import <GCDWebDAVServer.h>
#import <BottomComponentLib/ZHFProgressHUD.h>

@interface ZHFWebServeViewController ()
@property (nonatomic, strong) GCDWebServer *webServer;
@property (nonatomic, strong) GCDWebUploader *webUploader;
//用户可以使用任何WebDAV客户端（如Transmit（Mac），ForkLift（Mac）或Cyber​​Duck（Mac / Windows））从iOS应用程序沙箱中的目录上载，下载，删除文件和创建目录。
@property (nonatomic, strong) GCDWebDAVServer *davServer;

@property (weak, nonatomic) IBOutlet UIButton *serverBtn;

@end

@implementation ZHFWebServeViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Private Method


- (void)addUI {
    
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupLayout {
    
}

- (void)setupData {
    
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event
- (IBAction)serverBtnAction:(UIButton *)sender {
    
    NSString *path = [NSString stringWithFormat:@"服务器地址： %@",self.webServer.serverURL];
    
    [ZHFProgressHUD popupSuccessMessage:path];
    
    NSLog(@"%@",path);
}

- (IBAction)uploaderAction:(UIButton *)sender {
    NSString *path = [NSString stringWithFormat:@"上传服务器地址： %@",self.webUploader.serverURL];
    
    [ZHFProgressHUD popupSuccessMessage:path];
    
    NSLog(@"%@",path);
}

- (IBAction)davBtnAction:(UIButton *)sender {
    NSString *path = [NSString stringWithFormat:@"ftp服务器地址： %@",self.davServer.serverURL];
    
    [ZHFProgressHUD popupSuccessMessage:path];
    
    NSLog(@"%@",path);

}


#pragma mark - Delegate

#pragma mark - Getter, Setter
- (GCDWebServer *)webServer {
    
    if (!_webServer) {
        _webServer = [[GCDWebServer alloc] init];
        [_webServer addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
            return [GCDWebServerDataResponse responseWithHTML:@" <html> <body> <p> Hello World </ p> </ body> </ html>"];
        }];
        
        [_webServer startWithPort:8080 bonjourName:@"我是局域网web共享"];
    }
    return _webServer;
}

- (GCDWebUploader *)webUploader {
    if (!_webUploader) {
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentDir];
        [_webUploader startWithPort:8081 bonjourName:nil];
    }
    return _webUploader;
}

- (GCDWebDAVServer *)davServer {
    if (!_davServer) {
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _davServer = [[GCDWebDAVServer alloc] initWithUploadDirectory:documentDir];
        [_davServer startWithPort:8082 bonjourName:nil];
    }
    return _davServer;
}



#pragma mark - NSCopying

#pragma mark - NSObject


@end
