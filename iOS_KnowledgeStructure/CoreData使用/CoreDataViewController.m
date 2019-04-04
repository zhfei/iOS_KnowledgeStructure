//
//  CoreDataViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/4.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CoreDataViewController.h"
#import "CoreDataHelper.h"


@interface CoreDataViewController ()

@property (nonatomic, strong) CoreDataHelper *helper;
@end

@implementation CoreDataViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - Getter, Setter
- (CoreDataHelper *)helper {
    if (!_helper) {
        _helper = [CoreDataHelper new];
        [_helper createSqlite];
    }
    return _helper;
}
#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)addUI {
    
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupLayout {
    
}

- (void)setupData {
    
}



#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject

- (IBAction)addAction:(UIButton *)sender {
    [self.helper saveObject];
}
- (IBAction)deleteAction:(UIButton *)sender {
    [self.helper deleteObject];
}
- (IBAction)updateAction:(UIButton *)sender {
    [self.helper udpateObject];
}
- (IBAction)fetchAction:(UIButton *)sender {
    [self.helper fetchObject];
}
@end
