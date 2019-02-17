//
//  LifeCycleViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/17.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LifeCycleViewController.h"
#import "LiftCycleHeader.h"


@interface LifeCycleViewController ()

@end

@implementation LifeCycleViewController
//nib文件(xib,storyBoard)加载过程
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

//-------------------------------------------------------

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

- (void)loadView {
    [super loadView];
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LiftCycleHeader *liftCycyle = [LiftCycleHeader liftCycleHeader];
}

- (void)dealloc {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
