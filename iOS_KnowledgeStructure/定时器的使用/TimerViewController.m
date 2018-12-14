//
//  TimerViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/14.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //invalidate的作用是：解除引用链(RunLoop->timer->self),之后timer变为无效
    [self test1];
    [self test2];
    
}

#pragma mark - test1
- (void)test1 {
    //默认添加到当前线程的runloop中的defaultModel下
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
}
- (void)timerMethod {
    //invalidate的作用
    //1.将timer从runloop中移除
    //2.释放timer内部的资源，包括self
    //3.注意：timer被添加到哪个runloop,就要从哪个子线程释放。
    [self.timer invalidate];
}

#pragma mark - test2
- (void)test2 {
    [NSThread detachNewThreadSelector:@selector(newThreadMethod) toTarget:self withObject:nil];
}

- (void)newThreadMethod {
    //子线程下的runloop默认是不开启的，需要手动激活懒加载
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
    CFRunLoopRun();
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    NSLog(@"%@",[NSThread currentThread]);
}

#pragma mark - test3
- (void)test3 {
    //定时器触发原理
    //1.根据定时器设置，每次到了事件触发时间点，内核会发送一个消息到消息中心。
    //2.正常情况下，当runloop每次都会去消息中心查找响应端口的消息，进行处理。
    //3.当runloop处理了耗时任务，阻塞了消息的调用，但是被发送到消息中心的消息并没有消失
    //4.等runloop耗时任务处理完，进入下一个runloop周期时，还是会去处理刚才内核发过来的消息。
    //runloop观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"----监听到RunLoop状态发生改变---%zd", activity);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod2) userInfo:nil repeats:YES];
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    [self performSelector:@selector(busyOperation) withObject:nil afterDelay:0.5];
    
    // 释放Observer
    CFRelease(observer);
}

- (void)timerMethod2{
    NSLog(@"timer2 run");
}

- (void)busyOperation{
    NSLog(@"线程繁忙开始");
    long count = 0xffffffff;
    CGFloat calculateValue = 0;
    for (long i = 0; i < count; i++) {
        calculateValue = i/2;
    }
    NSLog(@"线程繁忙结束");
}



@end
