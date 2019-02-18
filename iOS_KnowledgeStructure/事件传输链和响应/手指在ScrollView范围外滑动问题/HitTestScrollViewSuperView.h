//
//  HitTestScrollViewSuperView.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/18.
//  Copyright © 2019年 zhf. All rights reserved.
//
//  滑动手势超出了ScrollView的范围，事件在它的父View时
//  手动将ScrollView返回出去，来处理这个事件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HitTestScrollViewSuperView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
