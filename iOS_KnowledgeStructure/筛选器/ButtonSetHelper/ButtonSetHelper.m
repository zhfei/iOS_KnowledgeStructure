//
//  ButtonSetHelper.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/9/24.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ButtonSetHelper.h"

#define SelectedColor [UIColor blueColor]
#define unSelectedColor [UIColor lightGrayColor]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BtnFont    [UIFont systemFontOfSize:14]

@implementation ButtonSetHelper

- (UIButton *)createBtn:(NSString *)title frame:(CGRect)frame {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = BtnFont;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self unSelectItem:btn];
    return btn;
}

- (CGFloat)calculateWidthString:(NSString *)string {
    CGFloat buttonHeigh = 28;
    CGSize size = CGSizeMake(CGFLOAT_MAX, buttonHeigh);
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: BtnFont};
    tempSize = [string boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return tempSize.width;
}

- (void)updateContextView:(UIView *)contextView buttonTitles:(NSArray<NSString *>*)titles {
    CGFloat leftMargin = 12;
    CGFloat topMargin = 6;
    CGFloat buttonHeigh = 28;
    
    [contextView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    __block CGFloat maxBtnX = 0;
    __block CGFloat maxBtnY = topMargin;
    
    [titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [self calculateWidthString:obj];
        CGRect frame = CGRectMake(maxBtnX + leftMargin, maxBtnY, width+16, buttonHeigh);
        if (CGRectGetMaxX(frame)+12 > ScreenWidth) {
            maxBtnY = CGRectGetMaxY(frame) + 6;
            maxBtnX = 0;
            frame = CGRectMake(maxBtnX + leftMargin, maxBtnY, width+16, buttonHeigh);
        }
        UIButton *btn = [self createBtn:obj frame:frame];
        btn.tag = idx;
        [contextView addSubview:btn];
        maxBtnX = CGRectGetMaxX(btn.frame);
    }];
}

- (void)selectItem:(UIButton *)btn {
    btn.selected = YES;
    
    [btn setTitleColor:SelectedColor forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = SelectedColor.CGColor;
    btn.layer.masksToBounds = YES;
}

- (void)unSelectItem:(UIButton *)btn {
    btn.selected = NO;
    
    [btn setTitleColor:unSelectedColor forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = unSelectedColor.CGColor;
    btn.layer.masksToBounds = YES;
}

- (void)btnAction:(UIButton *)sender {
    
}

@end
