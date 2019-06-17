//
//  RedBallButton.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/18.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RedBallButton.h"
#import <BottomComponentLib/UIView+BCLib.h>

@implementation RedBallButton
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
         [self setupUI];
    }
    return self;
}




#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    CGSize size = self.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, size.width-40, size.height-20, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, size.height-20, size.width-40);

    
    
    
    [self.titleLabel setBackgroundColor:[UIColor redColor]];

    UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 20, 20) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 0)];//[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 20, 20) cornerRadius:5];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor brownColor].CGColor;
    layer.path = bp.CGPath;
    self.titleLabel.layer.mask = layer;

}



@end
