//
//  CollectionViewToolViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/8/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CollectionViewToolViewController.h"
#import "CollectionViewTool.h"
#import "BitFieldPerson.h"
#import <Masonry.h>

@interface CollectionViewToolViewController ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, assign) NSInteger age;

@end

@implementation CollectionViewToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.name = @"jack";
    self.friends = @[@"tom",@"lucy"];
    self.age = 20;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CollectionViewTool *tool = [CollectionViewTool collectionViewTool];
    [self.view addSubview:tool];
    
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    BitFieldPerson *bfP = [[BitFieldPerson alloc] init];
    
    NSLog(@"%d,%d,%d,",bfP.heigh,bfP.rich,bfP.handsome);
}



@end
