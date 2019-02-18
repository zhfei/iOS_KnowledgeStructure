//
//  HitTestSuperView.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/18.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "HitTestSuperView.h"

@implementation HitTestSuperView
//当子View的边界超出父View时
//在判断点击的范围是否在 父View的范围内时，放弃这个判断
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    /**
     *  此注释掉的方法用来判断点击是否在父View Bounds内，
     *  如果不在父view内，就会直接不会去其子View中寻找HitTestView，return 返回
     */
    //  放弃对是否在父视图范围的判断
    //    if ([self pointInside:point withEvent:event]) {
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    return self;
    //    }
    return nil;
}
@end
