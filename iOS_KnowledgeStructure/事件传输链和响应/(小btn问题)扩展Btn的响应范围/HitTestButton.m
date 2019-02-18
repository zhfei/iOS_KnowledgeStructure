//
//  HitTestButton.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/18.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "HitTestButton.h"

CGFloat const kMinimumHitTestWidth = 50;
CGFloat const kMinimumHitTestHeight = 50;


@implementation HitTestButton
//修改button的位置判断方法，使其往外面宽高扩展
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    return CGRectContainsPoint(HitTestingBounds(self.bounds, kMinimumHitTestWidth, kMinimumHitTestHeight), point);
}

CGRect HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight) {
    CGRect hitTestingBounds = bounds;
    if (minimumHitTestWidth > bounds.size.width) {
        hitTestingBounds.size.width = minimumHitTestWidth;
        hitTestingBounds.origin.x -= (hitTestingBounds.size.width - bounds.size.width)/2;
    }
    if (minimumHitTestHeight > bounds.size.height) {
        hitTestingBounds.size.height = minimumHitTestHeight;
        hitTestingBounds.origin.y -= (hitTestingBounds.size.height - bounds.size.height)/2;
    }
    return hitTestingBounds;
}


@end
