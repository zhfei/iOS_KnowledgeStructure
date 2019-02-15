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

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    NSPredicate *predice =[NSPredicate predicateWithFormat:@""];
    
    NSArray *dataSource = [ArrayFiltrateViewModel dataSource];

}


@end
