//
//  UnionPerson.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/19.
//  Copyright © 2020年 zhf. All rights reserved.
//


#define kHeighMark (1<<0)
#define kRichMark (1<<1)
#define kHandsomeMark (1<<2)

#import "UnionPerson.h"

@interface UnionPerson()
/*
    根据 ‘共用体’的定义，在共用体分2个部分，一个是char类型， 一个是结构体；
    char类型占一个字节； 结构体分为三个单元，占3个字节；所以这个共用体的最大内存单元是一个字节的char
    所以这个共用体是只有一共字节的char类型。
 
    下面的结构体是起到了说明的作用
 */

{
    union {
        char bits;
        struct {
            char heigh : 1;
            char rich  : 1;
            char handsome :1;
        } ;
    } _heighRichHandsome;
}

@end

@implementation UnionPerson
#pragma mark - 按位与操作

- (void)setHeigh:(BOOL)heigh {
    if (heigh) {
        //设置YES时
        _heighRichHandsome.bits |= kHeighMark;
    } else {
        _heighRichHandsome.bits &= ~kHeighMark;
    }
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _heighRichHandsome.bits |= kRichMark;
    } else {
        _heighRichHandsome.bits &= ~kRichMark;
    }
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _heighRichHandsome.bits |= kHandsomeMark;
    } else {
        _heighRichHandsome.bits &= ~kHandsomeMark;
    }
}

#pragma mark - getter,按位与操作

- (BOOL)heigh {
    return (BOOL)(_heighRichHandsome.bits & kHeighMark);
}

- (BOOL)rich {
    return (BOOL)(_heighRichHandsome.bits & kRichMark);
}

- (BOOL)handsome {
    return (BOOL)(_heighRichHandsome.bits & kHandsomeMark);
}
@end
