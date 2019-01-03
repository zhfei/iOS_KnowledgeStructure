//
//  main.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSInteger age = 10;
        void(^completeBlock)(NSString *) = ^(NSString *name) {
            NSString *info = [NSString stringWithFormat:@"name:%@ - age:%d",name,age];
            NSLog(@"%@",info);
        };
        
        completeBlock(@"jack");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
