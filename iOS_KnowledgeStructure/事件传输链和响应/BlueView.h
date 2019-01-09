//
//  BlueView.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/9.
//  Copyright © 2019年 zhf. All rights reserved.
//
//  当事件传递给这个View时
//  当前view就会调用方法“hitTest:(CGPoint)point withEvent:(UIEvent *)event”，寻找最合适的view
//  1.如果当前对象可以处理触摸事件（userInteractionEnabled = NO 或者 hidden = YES 或者 alpha = 0.0 ~ 0.01 无法处理）
//  2.如果触摸的点，处在自己的范围内。
//  3.就会接着往下遍历自己的子控件，如果子控件都无法处理，就自己处理。否则的话就对子控件执行步骤1.2
//  4.如果当前view无法处理，就结束事件传递，不会传到下面子控件去。

//  在组合模式中，“hitTest:(CGPoint)point withEvent:(UIEvent *)event”方法返回的对象就是处理事件的对象。
//  如果返回nil,就丢弃这个事件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlueView : UIView

@end

NS_ASSUME_NONNULL_END
