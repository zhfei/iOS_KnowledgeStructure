//
//  main.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main3(int argc, char * argv[]) {
    @autoreleasepool {
        
        __block NSMutableArray *friends = [NSMutableArray array];;
        void(^completeBlock)(NSString *) = ^(NSString *name) {
            NSLog(@"%@--%@",name,friends);
        };
        
        completeBlock(@"jack");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
