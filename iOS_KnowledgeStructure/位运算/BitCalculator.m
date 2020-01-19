//
//  BitCalculator.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/19.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import "BitCalculator.h"

@implementation BitCalculator
- (void)setOptionType:(BCOptionType)optionType {
    //取出BCOptionTypeWWANSent
    if (optionType & BCOptionTypeWWANSent) {
        NSLog(@"包含BCOptionTypeWWANSent");
    } else if (optionType & BCOptionTypeWWANReceived) {
        NSLog(@"包含BCOptionTypeWWANReceived");
    }
}


@end
