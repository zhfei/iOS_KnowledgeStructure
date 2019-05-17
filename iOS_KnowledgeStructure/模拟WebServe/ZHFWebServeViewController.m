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
#import <BottomComponentLib/ZHFProgressHUD.h>

@interface ZHFWebServeViewController ()
@property (nonatomic, strong) GCDWebServer *webServer;
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

#pragma mark - Delegate

#pragma mark - Getter, Setter
- (GCDWebServer *)webServer {
    
    if (!_webServer) {
        _webServer = [[GCDWebServer alloc] init];
        [_webServer addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
            return [GCDWebServerDataResponse responseWithHTML:@" <html> <body> <p> Hello World </ p> </ body> </ html>"];
        }];
        
        [_webServer startWithPort:8080 bonjourName:nil];
    }
    return _webServer;
}

#pragma mark - NSCopying

#pragma mark - NSObject


- (IBAction)serverBtnAction:(UIButton *)sender {
    
    NSString *path = [NSString stringWithFormat:@"模拟服务器地址： %@",self.webServer.serverURL];
    
    [ZHFProgressHUD popMessage:path];
    
    NSLog(@"%@",path);
}

- (IBAction)uploaderAction:(UIButton *)sender {
}
@end
