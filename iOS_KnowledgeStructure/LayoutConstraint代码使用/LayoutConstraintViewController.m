//
//  LayoutConstraintViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LayoutConstraintViewController.h"
#import <Masonry.h>

static CGFloat const kMarginValue = 60.f;

@interface LayoutConstraintViewController ()
@property (nonatomic, strong) UILabel *contextLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *conBtn;


@end

@implementation LayoutConstraintViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == NSLayoutAttributeWidth) {
            obj.constant = arc4random_uniform(100);
            NSLog(@"obj.constant:%f",obj.constant);
        }
    }];
    [self.titleLabel setNeedsUpdateConstraints];
    [self.titleLabel setNeedsLayout];
    
//    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(arc4random_uniform(100));
//    }];
    
}

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)addUI {
    [self.view addSubview:self.contextLabel];
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor brownColor];
}

- (void)setupLayout {
    [self layout1];
    [self layout2];
    [self vflLayout2];
}

- (void)setupData {
    
}

// MARK: Tools
- (void)layout1 {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kMarginValue];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:kMarginValue];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.8 constant:-kMarginValue];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-kMarginValue];
    
    [self.view addConstraints:@[top,left,bottom,right]];
}

- (void)layout2 {
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    
    NSLayoutConstraint *heigh = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    
    [self.view addConstraints:@[centerX,centerY,width,heigh]];
}

- (void)vflLayout {
    //第四个参数，布局views的字典
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView, _blueView);
    //第三个参数，布局度量参数metres
    NSDictionary *metres = @{@"redViewW":@100,@"leftMargin":@50,@"rightMargin":@50};
    NSArray *HConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftMargin-[_redView(redViewW)]-11-[_blueView]-rightMargin-|" options:0 metrics:metres views:views];
    
    NSArray *VConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_redView(50)]-20-[_blueView(==_redView)]" options:0 metrics:metres views:views];
    
    [self.view addConstraints:HConstraints];
    [self.view addConstraints:VConstraints];
}

- (void)vflLayout2 {
    NSString *fmt = @"H:|-Margin-[_redView(ViewWidth)]-[_blueView(ViewWidth)]-Margin-|";
    NSDictionary *metrics = @{@"Margin":@(80),@"ViewWidth":@(100),@"ViewHeight":@(50)};
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView,_blueView);
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:fmt options:0 metrics:metrics views:views];
    NSString *fmt2 = @"V:|-Margin-[_redView(ViewHeight)]-|";
    NSString *fmt3 = @"V:|-Margin-[_blueView(ViewHeight)]-|";
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:fmt2 options:0 metrics:metrics views:views];
    NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:fmt3 options:0 metrics:metrics views:views];

    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
    [self.view addConstraints:constraints3];

}


#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject


- (UILabel *)contextLabel {
    
    if (!_contextLabel) {
        _contextLabel = [UILabel new];
        _contextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contextLabel.backgroundColor = [UIColor cyanColor];
        
        _contextLabel.font = [UIFont systemFontOfSize:27.0];
        _contextLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _contextLabel.textAlignment = NSTextAlignmentCenter;
        _contextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contextLabel.numberOfLines = 0;
        _contextLabel.accessibilityIdentifier = @"contextLabel";
        _contextLabel.text = @"容器内容";
    }
    return _contextLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.backgroundColor = [UIColor yellowColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:27.0];
        _titleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.accessibilityIdentifier = @"titleLabele";
        _titleLabel.text = @"子内容";
        
    }
    return _titleLabel;
}

- (UIView *)redView {
    
    if (!_redView) {
        _redView = [UIView new];
        _redView.translatesAutoresizingMaskIntoConstraints = NO;
        _redView.backgroundColor = [UIColor redColor];
        _redView.userInteractionEnabled = YES;
        _redView.alpha = 1;
    }
    return _redView;
}

- (UIView *)blueView {
    
    if (!_blueView) {
        _blueView = [UIView new];
        _blueView.translatesAutoresizingMaskIntoConstraints = NO;
        _blueView.backgroundColor = [UIColor blueColor];
        _blueView.userInteractionEnabled = YES;
        _blueView.alpha = 1;
    }
    return _blueView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.backgroundColor = [UIColor lightGrayColor];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _button.accessibilityIdentifier = @"EmptyButton";
        
        [_button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

@end
