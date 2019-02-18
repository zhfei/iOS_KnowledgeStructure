//
//  HitTestScrollViewSuperView.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/18.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "HitTestScrollViewSuperView.h"

@implementation HitTestScrollViewSuperView
//在ScrollView的父View中，手动将滑动事件赋给它的子View，scrollView处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if (hitTestView) {
        hitTestView = self.scrollView;
    }
    return hitTestView;
}

@end
