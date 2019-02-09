//
//  RefreshMonitor.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/8.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RefreshMonitor.h"


@interface RefreshMonitor ()
{
    CFRunLoopObserverRef _observer;
    CFRunLoopTimerRef _timer;
}
@property (nonatomic, strong) NSThread *monitorThread;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) BOOL excuting;

@end

@implementation RefreshMonitor
SingletonM(RefreshMonitor)
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.monitorThread = [[NSThread alloc] initWithTarget:[RefreshMonitor class] selector:@selector(monitorThreadEntryPoint) object:nil];
        [self.monitorThread start];
    }
    return self;
}

+ (void)monitorThreadEntryPoint
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"FluencyMonitor"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

- (void)start
{
    if (_observer) {
        return;
    }
    
    // 1.创建observer
    CFRunLoopObserverContext context = {0,(__bridge void*)self, NULL, NULL, NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                        kCFRunLoopAllActivities,
                                        YES,
                                        0,
                                        &runLoopObserverCallBack,
                                        &context);
    // 2.将observer添加到主线程的RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    // 3.创建一个timer，并添加到子线程的RunLoop中
    [self performSelector:@selector(addTimerToMonitorThread) onThread:self.monitorThread withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}

- (void)addTimerToMonitorThread
{
    if (_timer) {
        return;
    }
    // 创建一个timer
    CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
    CFRunLoopTimerContext context = {0, (__bridge void*)self, NULL, NULL, NULL};
    _timer = CFRunLoopTimerCreate(kCFAllocatorDefault, 0.1, 0.01, 0, 0,
                                  &runLoopTimerCallBack, &context);
    // 添加到子线程的RunLoop中
    CFRunLoopAddTimer(currentRunLoop, _timer, kCFRunLoopCommonModes);
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    RefreshMonitor *monitor = (__bridge RefreshMonitor*)info;
    NSLog(@"MainRunLoop---%@",[NSThread currentThread]);
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            monitor.startDate = [NSDate date];
            monitor.excuting = YES;
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            monitor.excuting = NO;
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}

static void runLoopTimerCallBack(CFRunLoopTimerRef timer, void *info)
{
    RefreshMonitor *monitor = (__bridge RefreshMonitor*)info;
    if (!monitor.excuting) {
        return;
    }
    
    // 如果主线程正在执行任务，并且这一次loop 执行到 现在还没执行完，那就需要计算时间差
    NSTimeInterval excuteTime = [[NSDate date] timeIntervalSinceDate:monitor.startDate];
    NSLog(@"定时器---%@",[NSThread currentThread]);
    NSLog(@"主线程执行了---%f秒",excuteTime);
    
    if (excuteTime >= 0.01) {
        NSLog(@"线程卡顿了%f秒",excuteTime);
        [monitor handleStackInfo];
    }
}

// 卡屏操作
- (void)handleStackInfo{
    
}

@end
