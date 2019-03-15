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
//    [self test1];
//    [self test2];
    [self test3];
}

#pragma mark - test1:在主线程中跑的NSTimer
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

#pragma mark - test2:在子线程中跑的NSTimer
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
    
    //1.runloop观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"----监听到RunLoop状态发生改变---%zd", activity);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    //2.定时器方法触发了
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod2) userInfo:nil repeats:YES];
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    
    //3.线程忙起来
    [self performSelector:@selector(busyOperation) withObject:nil afterDelay:0.5];
    // 释放Observer
    CFRelease(observer);
}
//定时器触发的方法
- (void)timerMethod2{
    NSLog(@"timer2 run");
}
//线程繁忙任务
- (void)busyOperation{
    NSLog(@"线程繁忙开始");
    long count = 0xffffffff;
    CGFloat calculateValue = 0;
    for (long i = 0; i < count; i++) {
        calculateValue = i/2;
    }
    NSLog(@"线程繁忙结束");
    
    
}


- (void)timerCollection {
    //1.NSTimer
    NSTimer *timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(timerMethod3) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //fire：可以上定时器立即触发，但不会改变预定周期性调度；invalidate：将timer从NSRunLoop中移出
    
    //2.CADisplayLink：基于屏幕刷新率(1/60)。其本质也是通过RunLoop。所以任务耗时也会卡屏。
    CADisplayLink *disLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkMethod3)];
    // 添加至RunLoop中
    [disLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    //invalidate：将timer从NSRunLoop中移出

    //3.GCDTimer:准时的原因是dispatch(dispatch source)源监听系统内核对象并处理。
    /** 创建定时器对象
     * para1: DISPATCH_SOURCE_TYPE_TIMER 为定时器类型
     * para2-3: 中间两个参数对定时器无用
     * para4: 最后为在什么调度队列中使用
     */
    dispatch_source_t gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    /** 设置定时器
     * para2: 任务开始时间
     * para3: 任务的间隔
     * para4: 可接受的误差时间，设置0即不允许出现误差
     * Tips: 单位均为纳秒
     */
    dispatch_source_set_timer(gcdTimer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    /** 设置定时器任务
     * 可以通过block方式
     * 也可以通过C函数方式
     */
    dispatch_source_set_event_handler(gcdTimer, ^{
        static int gcdIdx = 0;
        NSLog(@"GCD Method: %d", gcdIdx++);
        NSLog(@"%@", [NSThread currentThread]);
        
        if(gcdIdx == 5) {
            // 终止定时器
            dispatch_suspend(gcdTimer);
        }
    });
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(gcdTimer);
}

//1
- (void)timerMethod3 {
    
}
//2
- (void)linkMethod3 {
    
}


#pragma mark - FPS刷新器
- (void)setupDisplayLink {
    CADisplayLink *_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTicks:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)linkTicks:(CADisplayLink *)link {
    static NSInteger _scheduleTimes = 0;
    NSTimeInterval _timestamp;
    //执行次数
    _scheduleTimes ++;
    //当前时间戳
    if(_timestamp == 0){
        _timestamp = link.timestamp;
    }
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    if(timePassed >= 1.f) {
        CGFloat fps = _scheduleTimes/timePassed;
        printf("fps:%.1f, timePassed:%f\n", fps, timePassed);
    }
}
    







@end
