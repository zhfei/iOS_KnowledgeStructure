//
//  TenLockViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/2.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "EightLockViewController.h"
#import <libkern/OSAtomic.h>
#import <pthread.h>

@interface EightLockViewController ()

@end

@implementation EightLockViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self synchronizedTest1];
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

#pragma mark 1: OSSpinLock 自旋锁
//自旋锁，不公平锁，获取锁的顺序不是按照排队顺序
// OS_SPINLOCK_INIT： 默认值为 0,在 locked 状态时就会大于 0，unlocked状态下为 0
- (void)spinLockTest1 {
    __block OSSpinLock oslock = OS_SPINLOCK_INIT;
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        OSSpinLockLock(&oslock);
        sleep(4);
        NSLog(@"线程1");
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程1 解锁成功");
        NSLog(@"--------------------------------------------------------");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        OSSpinLockLock(&oslock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程2 解锁成功");
    });
    
    //结果
//    2019-03-02 17:20:09.017778+0800 iOS_KnowledgeStructure[39289:190314] 线程1 准备上锁
//    2019-03-02 17:20:09.017822+0800 iOS_KnowledgeStructure[39289:190504] 线程2 准备上锁
//    2019-03-02 17:20:09.017983+0800 iOS_KnowledgeStructure[39289:190504] 线程2
//    2019-03-02 17:20:09.018125+0800 iOS_KnowledgeStructure[39289:190504] 线程2 解锁成功
//    2019-03-02 17:20:13.023111+0800 iOS_KnowledgeStructure[39289:190314] 线程1
//    2019-03-02 17:20:13.023416+0800 iOS_KnowledgeStructure[39289:190314] 线程1 解锁成功
//    2019-03-02 17:20:13.023626+0800 iOS_KnowledgeStructure[39289:190314] --------------------------------------------------------
}

//自旋锁，不公平锁
// OS_SPINLOCK_INIT： 默认值为 0,在 locked 状态时就会大于 0，unlocked状态下为 0
- (void)spinLockTest2 {
    __block OSSpinLock oslock = OS_SPINLOCK_INIT;
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        OSSpinLockLock(&oslock);
        sleep(4);
        NSLog(@"线程1");
//        OSSpinLockUnlock(&oslock);
        NSLog(@"线程1 解锁成功");
        NSLog(@"--------------------------------------------------------");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        OSSpinLockLock(&oslock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程2 解锁成功");
    });
    
    //结果
//    2019-03-02 17:29:57.452437+0800 iOS_KnowledgeStructure[39416:197260] 线程1 准备上锁
//    2019-03-02 17:29:57.452489+0800 iOS_KnowledgeStructure[39416:198745] 线程2 准备上锁
//    2019-03-02 17:30:01.457632+0800 iOS_KnowledgeStructure[39416:197260] 线程1
//    2019-03-02 17:30:01.457940+0800 iOS_KnowledgeStructure[39416:197260] 线程1 解锁成功
//    2019-03-02 17:30:01.458173+0800 iOS_KnowledgeStructure[39416:197260] --------------------------------------------------------
    
   
}

#pragma mark 2: dispatch_semaphore 信号量

//dispatch_semaphore_create(1)： 传入值必须 >=0, 若传入为 0 则阻塞线程并等待timeout,时间到后会执行其后的语句
//dispatch_semaphore_wait(signal, overTime)：可以理解为 lock,会使得 signal 值 -1
//dispatch_semaphore_signal(signal)：可以理解为 unlock,会使得 signal 值 +1
- (void)dispatch_semaphoreTest1 {
    dispatch_semaphore_t signal = dispatch_semaphore_create(1); //传入值必须 >=0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 等待ing");
        dispatch_semaphore_wait(signal, overTime); //signal 值 -1
        NSLog(@"线程1");
        dispatch_semaphore_signal(signal); //signal 值 +1
        NSLog(@"线程1 发送信号");
        NSLog(@"--------------------------------------------------------");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 等待ing");
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"线程2");
        dispatch_semaphore_signal(signal);
        NSLog(@"线程2 发送信号");
    });
    
//    2019-03-02 17:34:34.567473+0800 iOS_KnowledgeStructure[39559:204779] 线程1 等待ing
//    2019-03-02 17:34:34.567476+0800 iOS_KnowledgeStructure[39559:204770] 线程2 等待ing
//    2019-03-02 17:34:34.567842+0800 iOS_KnowledgeStructure[39559:204779] 线程1
//    2019-03-02 17:34:34.568054+0800 iOS_KnowledgeStructure[39559:204779] 线程1 发送信号
//    2019-03-02 17:34:34.568091+0800 iOS_KnowledgeStructure[39559:204770] 线程2
//    2019-03-02 17:34:34.568204+0800 iOS_KnowledgeStructure[39559:204779] --------------------------------------------------------
//    2019-03-02 17:34:34.568261+0800 iOS_KnowledgeStructure[39559:204770] 线程2 发送信号
}


#pragma mark 3: pthread_mutex，自旋锁的替代方案
// YYKit 中采用的锁方案
- (void)pthread_mutexTest1 {
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        pthread_mutex_lock(&pLock);
        sleep(3);
        NSLog(@"线程1");
        pthread_mutex_unlock(&pLock);
    });
    
    //1.线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        pthread_mutex_lock(&pLock);
        NSLog(@"线程2");
        pthread_mutex_unlock(&pLock);
    });
    
//    2019-03-02 17:42:13.725719+0800 iOS_KnowledgeStructure[39697:212284] 线程1 准备上锁
//    2019-03-02 17:42:13.725739+0800 iOS_KnowledgeStructure[39697:212496] 线程2 准备上锁
//    2019-03-02 17:42:13.726070+0800 iOS_KnowledgeStructure[39697:212496] 线程2
//    2019-03-02 17:42:16.727368+0800 iOS_KnowledgeStructure[39697:212284] 线程1
}



#pragma mark 4: pthread_mutex(recursive) 递归锁
// 递归锁
- (void)pthread_mutex_recursiveTest1 {
    static pthread_mutex_t pLock;
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
    pthread_mutex_init(&pLock, &attr);
    pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用
    
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            pthread_mutex_lock(&pLock);
            if (value > 0) {
                NSLog(@"value: %d", value);
                RecursiveBlock(value - 1);
            }
            pthread_mutex_unlock(&pLock);
        };
        RecursiveBlock(5);
    });
//    2019-03-02 17:46:47.020924+0800 iOS_KnowledgeStructure[39817:217790] value: 5
//    2019-03-02 17:46:47.021248+0800 iOS_KnowledgeStructure[39817:217790] value: 4
//    2019-03-02 17:46:47.021448+0800 iOS_KnowledgeStructure[39817:217790] value: 3
//    2019-03-02 17:46:47.021642+0800 iOS_KnowledgeStructure[39817:217790] value: 2
//    2019-03-02 17:46:47.021835+0800 iOS_KnowledgeStructure[39817:217790] value: 1
}

#pragma mark 5: NSLock
// NSLock
- (void)NSLockTest1 {
    NSLock *lock = [NSLock new];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 尝试加速ing...");
        [lock lock];
        sleep(3);//睡眠5秒
        NSLog(@"线程1");
        [lock unlock];
        NSLog(@"线程1解锁成功");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 尝试加速ing...");
        BOOL x =  [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:4]];
        if (x) {
            NSLog(@"线程2");
            [lock unlock];
        }else{
            NSLog(@"失败");
        }
    });
    
//    2019-03-02 17:51:27.676196+0800 iOS_KnowledgeStructure[39943:224245] 线程1 尝试加速ing...
//    2019-03-02 17:51:27.676239+0800 iOS_KnowledgeStructure[39943:224256] 线程2 尝试加速ing...
//    2019-03-02 17:51:30.681577+0800 iOS_KnowledgeStructure[39943:224245] 线程1
//    2019-03-02 17:51:30.681949+0800 iOS_KnowledgeStructure[39943:224245] 线程1解锁成功
//    2019-03-02 17:51:30.681985+0800 iOS_KnowledgeStructure[39943:224256] 线程2
}


#pragma mark 6: NSConditionLock,可以设置线程依赖，做串行用
// NSConditionLock
- (void)NSConditionLockTest1 {
    NSConditionLock *cLock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if([cLock tryLockWhenCondition:0]){
            NSLog(@"线程1");
            [cLock unlockWithCondition:1];
        }else{
            NSLog(@"失败");
        }
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lockWhenCondition:3];
        NSLog(@"线程2");
        [cLock unlockWithCondition:2];
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lockWhenCondition:1];
        NSLog(@"线程3");
        [cLock unlockWithCondition:3];
    });
    
//    2019-03-02 17:58:00.000064+0800 iOS_KnowledgeStructure[40069:231258] 线程1
//    2019-03-02 17:58:00.000483+0800 iOS_KnowledgeStructure[40069:231254] 线程3
//    2019-03-02 17:58:00.000714+0800 iOS_KnowledgeStructure[40069:231248] 线程2
}

#pragma mark 7: NSRecursiveLock,递归锁，处理递归和循环
// NSRecursiveLock
- (void)NSRecursiveLockTest1 {
    NSLock *rLock = [NSRecursiveLock new];//[NSLock new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            [rLock lock];
            if (value > 0) {
                NSLog(@"线程%d", value);
                RecursiveBlock(value - 1);
            }
            [rLock unlock];
        };
        RecursiveBlock(4);
    });
    
//    2019-03-02 18:01:25.367698+0800 iOS_KnowledgeStructure[40239:236980] 线程4
//    2019-03-02 18:01:25.367950+0800 iOS_KnowledgeStructure[40239:236980] 线程3
//    2019-03-02 18:01:25.368164+0800 iOS_KnowledgeStructure[40239:236980] 线程2
//    2019-03-02 18:01:25.368369+0800 iOS_KnowledgeStructure[40239:236980] 线程1
}

#pragma mark 8: @synchronized 同步锁
// synchronized
- (void)synchronizedTest1 {
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            sleep(2);
            NSLog(@"线程1");
        }
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"线程2");
        }
    });
    
//    2019-03-02 18:03:12.787162+0800 iOS_KnowledgeStructure[40330:240039] 线程1
//    2019-03-02 18:03:12.787536+0800 iOS_KnowledgeStructure[40330:240034] 线程2
}

#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject

@end
