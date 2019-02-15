//
//  ArrayFiltrateViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/15.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ArrayFiltrateViewController.h"
#import "ArrayFiltrateViewModel.h"

@interface ArrayFiltrateViewController ()

@end

@implementation ArrayFiltrateViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setupUI];
}

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"age<%d",30];
    NSPredicate *predice1 =[NSPredicate predicateWithFormat:@"name='tom' && age<%d",30];
    NSPredicate *predice2 =[NSPredicate predicateWithFormat:@"self.name IN {'tom','rose'} || self.age IN {20,30}"];
    //以a开头
    NSPredicate *predice3 =[NSPredicate predicateWithFormat:@"name beginswith 'a'"];
    //以b结尾
    NSPredicate *predice4 =[NSPredicate predicateWithFormat:@"name endswith 'b'"];
    //包含c
    NSPredicate *predice5 =[NSPredicate predicateWithFormat:@"name contains 'c'"];
    //like匹配多字符
    //只要有s字母就满足
    NSPredicate *predice6 =[NSPredicate predicateWithFormat:@"name like 's'"];
    //第二个字符为s就满足,?代表一个字符
    NSPredicate *predice7 =[NSPredicate predicateWithFormat:@"name like '?s'"];
    
    NSArray *dataSource = [ArrayFiltrateViewModel dataSource];
    NSLog(@"result:%@",[dataSource filteredArrayUsingPredicate:predice]);

}


@end
