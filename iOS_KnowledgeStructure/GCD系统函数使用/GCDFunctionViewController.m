//
//  GCDFunctionViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/3.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "GCDFunctionViewController.h"

@interface GCDFunctionViewController ()

@end

@implementation GCDFunctionViewController
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

#pragma mark - Event

#pragma mark - Public Method

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

//改变队列优先级
//让多个串行队列，按照串行操作
- (void)serial_queue_targetText {
    //1.改变队列优先级
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    dispatch_queue_t bgQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //第一个参数：需要改变优先级的队列；
    //第二个参数：目标队列
    dispatch_set_target_queue(queue, bgQueue);
    
    
    //------------------------------------------------------------------------------------------
    
    
    //2.让多个串行队列，按照串行操作
    //多个串行队列，设置了target queue
    NSMutableArray *array = [NSMutableArray array];
    dispatch_queue_t serial_queue_target = dispatch_queue_create("queue_target", NULL);
    
    for (NSInteger index = 0; index < 5; index ++) {
        
        //分别给每个队列设置相同的target queue
        dispatch_queue_t serial_queue = dispatch_queue_create("serial_queue", NULL);
        dispatch_set_target_queue(serial_queue, serial_queue_target);
        [array addObject:serial_queue];
    }
    
    [array enumerateObjectsUsingBlock:^(dispatch_queue_t queue, NSUInteger idx, BOOL * _Nonnull stop) {
        
        dispatch_async(queue, ^{
            NSLog(@"任务%ld",idx);
        });
    }];
    
    
}


#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject

@end
