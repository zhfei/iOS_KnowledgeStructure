//
//  DispatchSourceViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "DispatchSourceViewController.h"
#import <netinet/in.h>
#import <dns_sd.h>

//Darwin.POSIX.arpa.inet

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
    //创建source源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    //设置source源配置
    //1.0:隔1秒触发；0.5：误差
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.5 * NSEC_PER_SEC);
    //设置source源事件
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"source触发的事件...");
    });
    //触发source源
    dispatch_resume(timer);
    
}

- (void)testSocketClient {
    //创建SocketContext,用来关联下面socket对象的上下文信息
    //void *info; 将self作为info传入，在后面回调中可以拿到当前VC
    CFSocketContext socketContext = {0,(__bridge void *)(self),NULL,NULL,NULL};
    
    //创建Socket对象
    //SocketCallBack函数的格式是d定义好的
    CFSocketRef socket = CFSocketCreate(kCFAllocatorDefault, AU_IPv4, SOCK_STREAM, IPPROTO_TCP, kCFSocketConnectCallBack, SocketCallBack, &socketContext);
    
    //创建socket需要连接的地址
    //memset结构体清零
    //htons将主机整型转换成网络字节顺序
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_len = sizeof(addr);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(19992);
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    
    //把地址转换成data
    CFDataRef dataRef = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr, sizeof(addr));
    
    //建立连接（1）如果socket设置的回调类型为kCFSocketNoCallBack，没有设置回调函数，就采用直接连接的方式
    //如果链接超时为负数，则把连接放在后台；如果_socket消息类型为kCFSocketConnectCallBack就触发回调
    CFSocketError socketError = CFSocketConnectToAddress(socket, dataRef, 5);
    //建立连接（2）如果socket设置的回调类型为kCFSocketConnectCallBack，并且设置了回调函数
    //加入循环中；将socket包装成一个source,当多个source在一个runloop时，顺序触发。0表示只有一个source
    CFSocketConnectToAddress(socket, dataRef, -1);
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopSourceRef socketSource = CFSocketCreateRunLoopSource(kCFAllocatorDefault, socket, 0);
    CFRunLoopAddSource(runloop, socketSource, kCFRunLoopCommonModes);
    CFRelease(socketSource);
    
    //连接成功/失败判断(1)
    if (socketError == kCFSocketSuccess) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //读数据流
        });
    }
}

//连接成功/失败判断(2)
void SocketCallBack(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
    DispatchSourceViewController *vc = (__bridge DispatchSourceViewController *)(info);
    
    if (data != NULL) {
        printf("连接失败\n");
    } else {
        printf("连接成功\n");
        [vc performSelectorInBackground:@selector(readStreamData) withObject:nil];
    }
    
}

- (void)readStreamData {
    //定义一个字符型变量
    char buffer[512];
    
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
