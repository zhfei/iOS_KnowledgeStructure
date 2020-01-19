//
//  BitFieldPerson.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/1/18.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import "BitFieldPerson.h"

@interface BitFieldPerson ()
{
    struct {
        char heigh : 1;
        char rich  : 1;
        char handsome :1;
    } _heighRichHandsome;
}
@end

@implementation BitFieldPerson
- (instancetype)init
{
    self = [super init];
    if (self) {
        _heighRichHandsome.heigh = YES;
        _heighRichHandsome.rich = NO;
        _heighRichHandsome.handsome = YES;
    }
    return self;
}


#pragma mark - 按位与操作

- (void)setHeigh:(BOOL)heigh {
    _heighRichHandsome.heigh = heigh;
}

- (void)setRich:(BOOL)rich {
    _heighRichHandsome.rich = rich;
}

- (void)setHandsome:(BOOL)handsome {
    _heighRichHandsome.handsome = handsome;
}

#pragma mark - getter,按位与操作

- (BOOL)heigh {
    //_heighRichHandsome.heigh只有一位0b1,当将一位的数据转化成8位的bool类型时
    //8位的bool类型都会被0b1所填充，变成0b1111 1111,即：0xff,即：255,而一个字节的范围是0~255
    //而0xff在转换成int时，有时候会转换成-1, 所以如果想通过数值表示bool的值，需要在前面加两个!!(非)或者将位域设置成2，用2l位表示
    //非零即真
    
    //0xFF 有符号表示-1, 无符号表示255
    
    
    return _heighRichHandsome.heigh;
}

- (BOOL)rich {
    return _heighRichHandsome.rich;
}

- (BOOL)handsome {
    return _heighRichHandsome.handsome;
}


@end
