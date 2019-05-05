//
//  NetWorkViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/5.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "NetWorkViewController.h"

@interface NetWorkViewController ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation NetWorkViewController
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
    //缓存策略在Get方法中采用,是苹果提供的内存和本地缓存的综合工具
    //设置自定义的缓存大小
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:5*1024*1024 diskCapacity:20*1024*1024 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    //NSURLRequestUseProtocolCachePolicy:采用响应头中的"Cache-Control"字段对于的缓存策略
    //NSURLRequestReturnCacheDataElseLoad:使用本地采用的缓存方式
    //缓存数据以file.db的形式保存在 /Library/Caches/项目名下。
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@",response);
    }];
    
    self.task = task;
    [task resume];
}

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
