//
//  block_VC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/4.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "block_VC.h"

typedef void(^CompleteBlock)(NSString *);
typedef void(^CompleteBlock2)();

@interface block_VC ()
{
    CompleteBlock2 completeBlock2_;
}
@property (nonatomic, copy) CompleteBlock completeBlock;
@end

@implementation block_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __block NSMutableArray *friends = [NSMutableArray array];;
    self.completeBlock = ^(NSString *name) {
        NSLog(@"%@--%@",name,friends);
    };
    
    completeBlock2_ = ^() {
        NSLog(@"hello world");
    };
    
    [self testBlock:self.completeBlock];
}

- (void)testBlock:(CompleteBlock)block {
    block(@"imToken...");
}

@end
