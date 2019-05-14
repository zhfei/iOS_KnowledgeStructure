//
//  OperationQueueViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/12.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "OperationQueueViewController.h"
#import <NSKeyValueObserving.h>

@interface OperationQueueViewController ()

@end

@implementation OperationQueueViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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

- (void)operationQueue1 {
    NSOperation *operation = [[NSOperation alloc] init];
    
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    [oq addOperation:operation];
    
    [oq addOperationWithBlock:^{
        NSLog(@"任务2...");
    }];
}

- (void)operationQueue2 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];


    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1...");
    }];
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务2...");
    }];
    
    [bo2 addDependency:bo];
    
    [oq addOperations:@[bo,bo2] waitUntilFinished:NO];
}

- (void)operationQueue3 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    oq.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1...");
    }];
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务2...");
    }];
    
    [bo2 addDependency:bo];
    
    [oq addOperations:@[bo,bo2] waitUntilFinished:NO];
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

//声明依赖关系，当firstName，lastName任何一个改变，都要触发fullName观察者
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"fullName"]) {
        return [NSSet setWithObjects:@"firstName",@"lastName", nil];
    }
}
//也可以把key写到方法中，直接返回
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForFullName:(NSString *)key {
    return [NSSet setWithObjects:@"firstName",@"lastName", nil];
}

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
