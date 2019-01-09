//
//  BlueView.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/9.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
// 返回谁，就是谁来接收并处理这个点击事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@---cmd:%@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return [super hitTest:point withEvent:event];
}
// 触摸的点是否在当前view的范围内
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@---cmd:%@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return [super pointInside:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@---cmd:%@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

//- (UIView *)superHitTest:(UIView *)subView pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    //可处理事件判断
//    if (subView.userInteractionEnabled && !subView.hidden && subView.alpha > 0.01) {
//    } else {
//        return nil;
//    }
//    // 触摸的点是否在当前view的范围内
//    if ([subView pointInside:point withEvent:event]) {
//    } else {
//        return nil;
//    }
//    // 没有子类时，自己处理
//    if (subView.subviews.count > 0) {
//        //有子类时，传递消息到子类
//        [self superHitTest:subView.subviews.lastObject pointInside:point withEvent:event];
//    } else {
//        return subView;
//    }
//    return nil;
//}

@end
