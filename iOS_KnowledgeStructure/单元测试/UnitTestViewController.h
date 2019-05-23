//
//  UnitTestViewController.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/5/22.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AsynCompleteBlock)();

@interface UnitTestViewController : UIViewController
//基本测试
//加
int plus(int a, int b) ;
- (NSInteger)add:(NSInteger)a b:(NSInteger)b;
//乘
long multiply(int a, int b);

//异步测试
- (void)loaderData:(AsynCompleteBlock)block;
@end

NS_ASSUME_NONNULL_END
