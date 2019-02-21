//
//  MyPoint.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/21.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "MyPoint.h"

@implementation MyPoint
@synthesize x = _x;
@synthesize y = _y;

+ (instancetype)makePointX:(float)x y:(float)y {
    MyPoint *point = [MyPoint new];
    point.x = x;
    point.y = y;
    return point;
}

@end
