//
//  ProgressWindow.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "ProgressWindow.h"


static ProgressWindow *progressWindow;
@implementation ProgressWindow
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.windowLevel = NSUIntegerMax;
        self.rootViewController = [UIViewController new];
        [self makeKeyAndVisible];
        [self setHidden:YES];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.5];
    }
    return self;
}

+ (instancetype)sharedProgressWindow {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        progressWindow = [[super allocWithZone:NULL] init];
    });
    return progressWindow;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedProgressWindow];
}

- (id)copyWithZone:(NSZone *)zone {
    return progressWindow;
}

@end
