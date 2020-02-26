//
//  CollectionViewTool.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/8/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CollectionViewTool.h"
#import "BCAlertController.h"
#import <Masonry.h>

const CGFloat leftMargin = 20;
const CGFloat topMargin = 10;


@interface CollectionViewTool () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) CGFloat maxBtnX;
@end

@implementation CollectionViewTool

#pragma mark - Life Cycle
- (void)awakeFromNib {
    [self setupUI];
}

#pragma mark - Private Method
- (void)setupUI {
    self.dataSource = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6"];
    
    [self.dataSource enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(self.maxBtnX + 20, topMargin, 60, 30);
        UIButton *btn = [self createBtn:obj frame:frame];
        [self.scrollView addSubview:btn];
        self.maxBtnX = CGRectGetMaxX(btn.frame);
    }];
    
    [self.scrollView setContentSize:CGSizeMake(self.maxBtnX+20, 50)];
}

- (UIButton *)createBtn:(NSString *)title frame:(CGRect)frame {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.masksToBounds = YES;
    return btn;
}

#pragma mark - Public Method
+ (instancetype)collectionViewTool {
    CollectionViewTool *header = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewTool" owner:nil options:nil][0];
    return header;
}

#pragma mark - Event
- (void)btnAction:(UIButton *)sender {
    [BCAlertController showWithTitle:[sender currentTitle] message:nil btn1Title:@"确定" btn1Handle:^(UIAlertAction * _Nullable action) {
        
    }];
}

#pragma mark - Getter, Setter



@end
