//
//  RunLoopViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/1.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RunLoopViewController.h"
#import "RefreshMonitor.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[RefreshMonitor sharedRefreshMonitor] start];
}

- (void)test1 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
    });
}

- (void)timerFire {
    NSLog(@"mode:%@",[[NSRunLoop currentRunLoop] currentMode]);
}

@end
