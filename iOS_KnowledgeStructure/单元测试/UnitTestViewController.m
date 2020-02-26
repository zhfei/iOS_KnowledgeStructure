//
//  UnitTestViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/22.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "UnitTestViewController.h"
#import <BottomComponentLib/BCNetworking.h>
#import <BottomComponentLib/BCRequestParameter.h>
#import <BottomComponentLib/BCProgressHUD.h>

@interface UnitTestViewController ()

@end

@implementation UnitTestViewController
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
int plus(int a, int b) {
    return a + b;
}

long multiply(int a, int b) {
    return a * b;
}

- (NSInteger)add:(NSInteger)a b:(NSInteger)b {
    return a+b;
}

- (void)loaderData:(AsynCompleteBlock)block  {
    BCRequestParameter *para = [[BCRequestParameter alloc] init];
    [BCProgressHUD popMessage:@"加载中..."];
    [BCNetworking asyncWithParameter:para success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [BCProgressHUD dismissMessage];
        if (block) {
            block();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [BCProgressHUD dismissMessage];
        if (block) {
            block();
        }
    }];
}

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
