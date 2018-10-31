//
//  GCDUtility_OC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "GCDUtility_OC.h"

@implementation GCDUtility_OC
//单例
static GCDUtility_OC *single;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [super allocWithZone:zone];
    });
    return single;
}

+ (instancetype)single {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[self class] new];
    });
    return single;
}

- (id)copyWithZone:(NSZone *)zone
{
    return single;
}

//异步主线程
- (void)main_async {
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

//延时执行
- (void)after {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

//定时器
- (void)timer {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.001 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
    });
    dispatch_resume(timer);
}

//异步任务组
- (void)group {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        
    });
    //在上面任务完成前，阻塞当前线程
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_async(group, queue, ^{
        
    });
    //跃过下面语句，继续执行
    dispatch_group_notify(group, queue, ^{
       //最后结束
    });

}

- (void)group2 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //利用内存管理引用计数理论，enter +1, leave -1,等为0时，通知组任务结束。
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        dispatch_group_leave(group);
    });
    //在上面任务完成前，阻塞当前线程
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_async(group, queue, ^{
        
    });
    //跃过下面语句，继续执行
    dispatch_group_notify(group, queue, ^{
        //最后结束
    });
    
}

//信号量（深层异步任务同步）
- (void)semaphore {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_semaphore_signal(sem);
            });
        });
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_semaphore_signal(sem);
        });
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            //结束
        });
    });
}
@end
