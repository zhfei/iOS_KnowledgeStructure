//
//  LabelContainer.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/25.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LabelContainer.h"
#import <Masonry.h>

@interface LabelContainer ()
@property (nonatomic, strong) UILabel *left;
@property (nonatomic, strong) UILabel *right;

@property (nonatomic, strong) UILabel *left1;
@property (nonatomic, strong) UILabel *right1;
@end

@implementation LabelContainer
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupUI1];
    }
    return self;
}



#pragma mark - Getter, Setter
- (UILabel *)left {
    if (!_left) {
        _left = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
        _left.backgroundColor = [UIColor redColor];
        _left.text = @"_left_left_left_left_left_left_left_left";
    }
    return _left;
}

- (UILabel *)right {
    if (!_right) {
        _right = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
        _right.backgroundColor = [UIColor blueColor];
        _right.text = @"_right";
    }
    return _right;
}

- (UILabel *)left1 {
    if (!_left1) {
        UILabel * textLabel = [UILabel new];
        textLabel.font = [UIFont systemFontOfSize:16];
        NSString *str = @"222222222222222";
        textLabel.text = str;
        textLabel.backgroundColor = [UIColor redColor];
        textLabel.numberOfLines = 0;//根据最大行数需求来设置
        textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(200, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        textLabel.frame = CGRectMake(20, 70, expectSize.width, expectSize.height);

        _left1 = textLabel;
    }
    return _left1;
}

- (UILabel *)right1 {
    if (!_right1) {
        _right1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
        _right1.backgroundColor = [UIColor blueColor];
        _right1.text = @"_right";
    }
    return _right1;
}

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
//左侧填充，宽度自适应。
//右侧紧挨着左label，伴随左侧而改变
- (void)setupUI {
    [self addSubview:self.left];
    [self addSubview:self.right];
    
    [self.left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];
    
    [self.right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.left.mas_right);
        make.top.mas_equalTo(self.left);
        make.right.mas_offset(0);
    }];
    [self.left setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupUI1 {
    [self addSubview:self.left1];
    [self addSubview:self.right1];
    [self.right1 setFrame:CGRectMake(CGRectGetMaxX(self.left1.frame)+10, CGRectGetMinY(self.left1.frame), 50, 20)];
}


@end
