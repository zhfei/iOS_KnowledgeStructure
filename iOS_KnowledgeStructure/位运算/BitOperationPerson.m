//
//  BitOperationPerson.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/18.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import "BitOperationPerson.h"


//#define kHeighMark 1
//#define kRichMark 2
//#define kHandsomeMark 4
//
//#define kHeighMark 0b00000001
//#define kRichMark 0b00000010
//#define kHandsomeMark 0b00000100

#define kHeighMark (1<<0)
#define kRichMark (1<<1)
#define kHandsomeMark (1<<2)

//掩码：用于与(&)操作，提取某位的值

@interface BitOperationPerson ()
{
    char _heighRichHandsome;
}
@end

@implementation BitOperationPerson
- (instancetype)init
{
    self = [super init];
    if (self) {
        _heighRichHandsome = 0b00000000;
    }
    return self;
}

#pragma mark - 按位与操作

- (void)setHeigh:(BOOL)heigh {
    if (heigh) {
        //设置YES时
        _heighRichHandsome |= kHeighMark;
    } else {
        _heighRichHandsome &= ~kHeighMark;
    }
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _heighRichHandsome |= kRichMark;
    } else {
        _heighRichHandsome &= ~kRichMark;
    }
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _heighRichHandsome |= kHandsomeMark;
    } else {
        _heighRichHandsome &= ~kHandsomeMark;
    }
}

#pragma mark - getter,按位与操作

- (BOOL)heigh {
    return (BOOL)(_heighRichHandsome & kHeighMark);
}

- (BOOL)rich {
    return (BOOL)(_heighRichHandsome & kRichMark);
}

- (BOOL)handsome {
    return (BOOL)(_heighRichHandsome & kHandsomeMark);
}



@end
