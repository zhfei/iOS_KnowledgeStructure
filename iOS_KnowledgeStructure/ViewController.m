//
//  ViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)compareTest {
    NSArray *arr = [NSArray arrayWithObjects:@"a",@"b",@"c", nil];
    [arr sortedArrayUsingSelector:@selector(compare:)];
    
}

@end
