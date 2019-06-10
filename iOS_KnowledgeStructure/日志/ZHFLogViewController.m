//
//  ZHFLogViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/6/10.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ZHFLogViewController.h"

@interface ZHFLogViewController ()

@end

@implementation ZHFLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)logInfo:(NSString *)format, ... {
    va_list arguments;
    va_start(arguments, format);
    // TODO: 打印到本地文件
    //清理参数变量数组
    va_end(arguments);
}

@end
