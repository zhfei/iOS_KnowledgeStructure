//
//  ScrolleViewApplyVC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/28.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ScrolleViewApplyVC.h"
#import <Masonry.h>
#import <BottomComponentLib/UIFactory.h>
#import <BottomComponentLib/UIColor+Transform.h>

@interface ScrolleViewApplyVC () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ScrolleViewApplyVC
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Getter, Setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, widthS, heightS)];
        
        CGFloat heighBtn = 100;
        
        for (int i = 0; i < 10; i++) {
            UIButton *btn = [UIFactory buttonFactory:@"text"];
            [btn setBackgroundColor:[UIColor randomColor]];
            [btn setFrame:CGRectMake(0, (heighBtn+20)*i, widthS, heighBtn)];
            [_scrollView addSubview:btn];
        }
        [_scrollView setContentSize:CGSizeMake(widthS, (heighBtn+20)*10)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        
    }
//    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 60, 0)];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupLayout {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)setupData {
    
}

- (void)resetUI {
    
}

- (void)resetLayout {
    
}

- (void)resetData {
    
}



#pragma mark - Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView:%@",NSStringFromCGPoint(scrollView.contentOffset));
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}


#pragma mark - NSCopying

#pragma mark - NSObject

@end
