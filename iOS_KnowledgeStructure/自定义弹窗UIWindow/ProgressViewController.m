//
//  ProgressViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressWindow.h"
#import <BottomComponentLib/UIButton+ZHFShortCut.h>
#import <BottomComponentLib/Macro.h>

@interface ProgressViewController ()

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WeakSelf
    UIButton *btn = [UIButton shortCutButtonWithFrame:CGRectMake(100, 100, 100, 50) title:@"点击我！" TapAction:^(UIButton *btn) {
        StrongSelf
        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSLog(@"点击我！");
    }];
    [self.view addSubview:btn];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[ProgressWindow sharedProgressWindow] setHidden:YES];
}

@end
