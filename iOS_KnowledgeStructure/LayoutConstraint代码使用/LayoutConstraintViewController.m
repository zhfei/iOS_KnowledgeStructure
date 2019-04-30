//
//  LayoutConstraintViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LayoutConstraintViewController.h"

static CGFloat const kMarginValue = 60.f;

@interface LayoutConstraintViewController ()
@property (nonatomic, strong) UILabel *contextLabel;
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




#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method


- (void)addUI {
    [self.view addSubview:self.contextLabel];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)setupLayout {
    [self layout2];
}

- (void)setupData {
    
}

// MARK: Tools
- (void)layout1 {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kMarginValue];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:kMarginValue];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.5 constant:-kMarginValue];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-kMarginValue];
    
    [self.view addConstraints:@[top,left,bottom,right]];
}

- (void)layout2 {
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    
    NSLayoutConstraint *heigh = [NSLayoutConstraint constraintWithItem:self.contextLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    
    [self.view addConstraints:@[centerX,centerY,width,heigh]];
}

#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject


- (UILabel *)contextLabel {
    
    if (!_contextLabel) {
        _contextLabel = [UILabel new];
        _contextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contextLabel.backgroundColor = [UIColor redColor];
        
        _contextLabel.font = [UIFont systemFontOfSize:27.0];
        _contextLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _contextLabel.textAlignment = NSTextAlignmentCenter;
        _contextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contextLabel.numberOfLines = 0;
        _contextLabel.accessibilityIdentifier = @"empty set title";
        
    }
    return _contextLabel;
}

@end
