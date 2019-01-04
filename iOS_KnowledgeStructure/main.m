//
//  main.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void(^completeBlock3)(NSString *);
void(^completeBlock4)(NSString *);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        __block NSMutableArray *friends = [NSMutableArray array];;
        void(^completeBlock)(NSString *) = ^(NSString *name) {
            NSLog(@"%@--%@",name,friends);
        };
        
        void(^completeBlock2)(NSString *) = [completeBlock copy];
        
        completeBlock3  = [completeBlock copy];
        
        completeBlock4 = ^(NSString *name) {
            NSLog(@"%@--%@",name,friends);
        };
        
        NSLog(@"completeBlock:%@---completeBlock3:%@---completeBlock4:%@",completeBlock,completeBlock3,completeBlock3);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

//(lldb) expression -P 5 -- completeBlock3
//(void (^)(NSString *)) $3 = 0x000000010a061130 {
//    __isa = __NSMallocBlock__
//    __flags = -1023410170
//    __reserved = 0
//    __FuncPtr = 0x000000010a061130 (iOS_KnowledgeStructure`__main_block_invoke at main.m:19) {}
//}
