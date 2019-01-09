//
//  RedView.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/9.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RedView.h"

@implementation RedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@---cmd:%@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@---cmd:%@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return [super pointInside:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@---cmd:%@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


@end
