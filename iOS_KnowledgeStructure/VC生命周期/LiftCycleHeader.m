//
//  LiftCycleHeader.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/17.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LiftCycleHeader.h"

@implementation LiftCycleHeader
//nib文件(xib,storyBoard)加载过程
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

+ (instancetype)liftCycleHeader {
    LiftCycleHeader *header = [[NSBundle mainBundle] loadNibNamed:@"LiftCycleHeader" owner:nil options:nil][0];
    return header;
}


@end
