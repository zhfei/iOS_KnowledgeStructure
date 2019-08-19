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
#import <BottomComponentLib/UIColor+BCLib.h>
#import "Xtrace.h"

#define widthS [UIScreen mainScreen].bounds.size.width
#define heightS [UIScreen mainScreen].bounds.size.height


@interface ScrolleViewApplyVC () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //取消内容边界扩展
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Getter, Setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, widthS, heightS)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageV = [UIImageView new];
        imageV.contentMode = UIViewContentModeCenter;
        _imageView = imageV;
    }
    return _imageView;
}

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [Xtrace showReturns:NO];
//    [Xtrace traceInstance:self.scrollView];
    [self.view xtrace];

    [self.view addSubview:self.scrollView];
    [self scrollImageView];
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

- (void)scrollImageView {
    self.imageView.frame = self.scrollView.bounds;
    self.imageView.image = [UIImage imageNamed:@"dogAndDuck"];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.minimumZoomScale = 0.5;
}

- (void)btnList {
    CGFloat heighBtn = 100;
    for (int i = 0; i < 10; i++) {
        UIButton *btn = [UIFactory buttonFactory:@"text"];
        [btn setBackgroundColor:[UIColor randomColor]];
        [btn setFrame:CGRectMake(0, (heighBtn+20)*i, widthS, heighBtn)];
        [_scrollView addSubview:btn];
    }
    [_scrollView setContentSize:CGSizeMake(widthS, (heighBtn+20)*10)];
}

#pragma mark - Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView:%@",NSStringFromCGPoint(scrollView.contentOffset));
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    
}


#pragma mark - NSCopying

#pragma mark - NSObject

@end
