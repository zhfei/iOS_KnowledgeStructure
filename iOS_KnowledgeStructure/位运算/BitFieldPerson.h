//
//  BitFieldPerson.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/18.
//  Copyright © 2020年 zhf. All rights reserved.
//
//  采用结构体中声明位域，既可以访问方便，有可以节约内存
//  位域：声明每个变量占据多少个位。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BitFieldPerson : NSObject

- (void)setHeigh:(BOOL)heigh ;

- (void)setRich:(BOOL)rich ;

- (void)setHandsome:(BOOL)handsome ;

- (BOOL)heigh ;

- (BOOL)rich ;

- (BOOL)handsome ;

@end

NS_ASSUME_NONNULL_END
