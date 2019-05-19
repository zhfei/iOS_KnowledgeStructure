//
//  DispatchSourceViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "DispatchSourceViewController.h"

@interface DispatchSourceViewController ()

@end

@implementation DispatchSourceViewController
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

//MARK：test1
- (void)testGCDSource {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, <#dispatchQueue#>);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, <#intervalInSeconds#> * NSEC_PER_SEC, <#leewayInSeconds#> * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        <#code to be executed when timer fires#>
    });
    dispatch_resume(timer);
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
