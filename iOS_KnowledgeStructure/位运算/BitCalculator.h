//
//  BitCalculator.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/19.
//  Copyright © 2020年 zhf. All rights reserved.
//
//  位运算使用
//  取值时，使用&， 通过mask掩码与总值相‘与’，得到目标值。
//  设置值时， 使用|, 通过mask掩码将多个值相“或”，得到要传入的值。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//位类型枚举
typedef NS_OPTIONS(NSUInteger, BCOptionType) {
    BCOptionTypeWWANSent     = 1 << 0,
    BCOptionTypeWWANReceived = 1 << 1,
    BCOptionTypeWIFISent     = 1 << 2,
    BCOptionTypeWIFIReceived = 1 << 3,
    BCOptionTypeAWDLSent     = 1 << 4,
    BCOptionTypeAWDLReceived = 1 << 5,
};



@interface BitCalculator : NSObject
@property (nonatomic, assign) BCOptionType optionType;

@end

NS_ASSUME_NONNULL_END
