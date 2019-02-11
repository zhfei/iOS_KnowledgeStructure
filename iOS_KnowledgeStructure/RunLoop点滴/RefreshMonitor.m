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
        self.monitorThread = [[NSThread alloc] initWithTarget:[RefreshMonitor class] selector:@selector(monitorThreadEntry) object:nil];
        [self.monitorThread start];
    }
    return self;
}

+ (void)monitorThreadEntry {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"监听常驻线程"];
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
    }
}

//观察者在主线程进行观察
- (void)startObserver {
    if (_observer) {
        return;
    }
    //1.创建obserser
    CFRunLoopObserverContext context = {0,(__bridge void *)self,NULL,NULL,NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopObserverCallBack, &context);
    //添加obserser到runloop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    //添加timer到runloop
    [self performSelector:@selector(addTimerToMonitorThread) onThread:self.monitorThread withObject:nil waitUntilDone:NO
     modes:@[NSRunLoopCommonModes]];
}

//timer在子线程进行不断调用，判断，打印
- (void)addTimerToMonitorThread {
    if (_timer) {
        return;
    }
    //创建一个timer
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopTimerContext context = {0, (__bridge void*)self, NULL, NULL, NULL};
    _timer = CFRunLoopTimerCreate(kCFAllocatorDefault, 0.1, 0.01, 0, 0, &runLoopTimerCallBack, &context);
    CFRunLoopAddTimer(runloop, _timer, kCFRunLoopCommonModes);
}

static void runloopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    RefreshMonitor *monitor = (__bridge RefreshMonitor *)info;
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
