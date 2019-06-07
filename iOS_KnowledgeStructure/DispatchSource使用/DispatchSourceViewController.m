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
{
    CFSocketRef _socket;
}
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

// MARK: Clinet 客户端

- (void)testSocketClient {
    //创建SocketContext,用来关联下面socket对象的上下文信息
    //void *info; 将self作为info传入，在后面回调中可以拿到当前VC
    CFSocketContext socketContext = {0,(__bridge void *)(self),NULL,NULL,NULL};
    
    //创建Socket对象
    //SocketCallBack函数的格式定义好的
    CFSocketRef socket = CFSocketCreate(kCFAllocatorDefault, AU_IPv4, SOCK_STREAM, IPPROTO_TCP, kCFSocketConnectCallBack, SocketCallBack, &socketContext);
    _socket = socket;
    
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
    
    //若无错误发生，recv返回读入的字节数
    long readData;
    while (readData = recv(CFSocketGetNative(_socket), buffer, readData, 0)) {
        NSString *content = [[NSString alloc] initWithBytes:buffer length:readData encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"content:%@",content);
        });
    }
    
}

- (void)sendStreamToServer {
    NSString *targetStr = @"target data";
    
    const char *data = [targetStr UTF8String];
    //发送成功时，返回发送数据的长度
    int sendData = send(CFSocketGetNative(_socket), data, strlen(data), 0);
    if (sendData < 0) {
        printf("发送失败");
    }
}

// MARK: Server 服务端
- (void)testSocketServer {
    CFSocketRef serverSocket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAcceptCallBack, TCPServerAcceptCallBack, NULL);
    
    //设置允许重用本地地址和端口
//    int setsockopt(int sock,  //需要设置选项的套接字
//                   int level, //选项所在的协议层
//                   int optname, //需要访问的选项名
//                   const void *optval, //新选项值的缓冲
//                   socklen_t optlen //现选项的长度
//                   );
    BOOL reuse = YES;
    setsockopt(CFSocketGetNative(serverSocket), SOL_SOCKET, SO_REUSEADDR, (const void *)&reuse, sizeof(reuse));
    
    //设置socket连接地址
    //定义sockaddr_in类型的变量，该变量将作为CFSocket的地址
    struct sockaddr_in Socketaddr;
    memset(&Socketaddr, 0, sizeof(Socketaddr));
    Socketaddr.sin_len = sizeof(Socketaddr);
    Socketaddr.sin_family = AF_INET;
    //设置该服务器监听本机任意可用的IP地址
    //                addr4.sin_addr.s_addr = htonl(INADDR_ANY);
    //设置服务器监听地址
    Socketaddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    //设置服务器监听端口
    Socketaddr.sin_port = htons(19992);
    
    //转换地址类型，绑定到指定的IP地址
    CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&Socketaddr, sizeof(Socketaddr));
    if (CFSocketSetAddress(serverSocket, address) != kCFSocketSuccess) {
        if (serverSocket != NULL) {
            CFRelease(serverSocket);
        }
        serverSocket = NULL;
        exit(-1);
    }
    
    //根据socket转化成source，并添加到runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, serverSocket, 0);
    CFRunLoopAddSource(runloop, source, kCFRunLoopCommonModes);
    CFRelease(runloop);
    CFRunLoopRun();
}


//有客户端连接进来的回调函数
void TCPServerAcceptCallBack(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
    //如果有客户端Socket连接进来
    if (kCFSocketAcceptCallBack == type) {
        
        //获取本地Socket的Handle，这个回调事件的类型是kCFSocketAcceptCallBack，这个data就是一个CFSocketNativeHandle类型指针
        CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle *)data;
        
        //定义一个255数组接收这个新的data转成的socket的地址，SOCK_MAXADDRLEN意思是最长的可能的地址
        uint8_t name[SOCK_MAXADDRLEN];
        //这个地址数组的长度
        socklen_t namelen = sizeof(name);
        
        /**
         int getpeername(int,已经连接的Socket
         struct sockaddr * __restrict,用来接收地址信息
         socklen_t * __restrict 地址长度
         )
         作用是从已经连接的Socket中获得地址信息，存到参数2中，地址长度放到参数3中
         
         成功是返回0，如果失败了则返回别的数字，对应不同错误码
         
         */
        //获取Socket信息
        if (getpeername(nativeSocketHandle,
                        (struct sockaddr *)name,
                        &namelen) != 0 ) {
            
            perror("getpeername:");
            exit(1);
        }
        
        //获取连接信息
        struct sockaddr_in *addr_in = (struct sockaddr_in *)name;
        // ----inet_ntoa将网络地址转换成“.”点隔的字符串格式
//        NSLog(@"%s:%d连接进来了",inet_ntoa(addr_in->sin_addr),addr_in->sin_port);
        
        //创建一组可读/写的CFStream
        void * readStreamRef  = NULL;
        void * writeStreamRef = NULL;
        
        // ----创建一个和Socket对象相关联的读取数据流
        CFStreamCreatePairWithSocket(kCFAllocatorDefault, //内存分配器
                                     nativeSocketHandle, //准备使用输入输出流的socket
                                     &readStreamRef, //输入流
                                     &writeStreamRef);//输出流
        
        // ----CFStreamCreatePairWithSocket(）操作成功后，readStreamRef和writeStreamRef都指向有效的地址，因此判断是不是还是之前设置的NULL就可以了
        if (readStreamRef && writeStreamRef) {
            
            //打开输入流和输出流
            CFReadStreamOpen(readStreamRef);
            CFWriteStreamOpen(writeStreamRef);
            
            // ----一个结构体包含程序定义数据和回调用来配置客户端数据流行为
            NSString *aaa = @"earth，wind，fire，be my call";
            
            CFStreamClientContext context = {0,(__bridge void *)(aaa),NULL,NULL};
            
            /**
             指定客户端的数据流，当特定事件发生的时候，接受回调
             Boolean CFReadStreamSetClient ( CFReadStreamRef stream, 需要指定的数据流
             CFOptionFlags streamEvents, 具体的事件，如果为NULL，当前客户端数据流就会被移除
             CFReadStreamClientCallBack clientCB, 事件发生回调函数，如果为NULL，同上
             CFStreamClientContext *clientContext 一个为客户端数据流保存上下文信息的结构体，为NULL同上
             );
             返回值为TRUE就是数据流支持异步通知，FALSE就是不支持
             */
            if (!CFReadStreamSetClient(readStreamRef,
                                       kCFStreamEventHasBytesAvailable,
                                       readStream,
                                       &context)) {
                exit(1);
            }
            
            // ----将数据流加入循环
            CFReadStreamScheduleWithRunLoop(readStreamRef,
                                            CFRunLoopGetCurrent(),
                                            kCFRunLoopCommonModes);
            
            const char *str = "welcome！\n";
            
            //向客户端输出数据
            CFWriteStreamWrite(writeStreamRef, (UInt8 *)str, strlen(str) + 1);
            
        }else {
            // ----如果失败就销毁已经连接的Socket
            close(nativeSocketHandle);
        }
    }
}

//向客户端发送数据
void readStream(CFReadStreamRef readStream,
                CFStreamEventType evenType,
                void *clientCallBackInfo) {
    UInt8 buff[2048];
    
    NSString *aaa = (__bridge NSString *)(clientCallBackInfo);
    NSLog(@"%@", aaa);
    
    // ----从可读的数据流中读取数据，返回值是多少字节读到的，如果为0就是已经全部结束完毕，如果是-1则是数据流没有打开或者其他错误发生
    CFIndex hasRead = CFReadStreamRead(readStream, buff, sizeof(buff));
    
    if (hasRead > 0) {
        printf("接收到数据：%s\n",buff);
        
        const char *str = "for the lich king！！\n";
        //向客户端输出数据
//        CFWriteStreamWrite(writeStreamRef, (UInt8 *)str, strlen(str) + 1);
    }
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
