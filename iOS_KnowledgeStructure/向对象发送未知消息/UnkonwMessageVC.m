//
//  UnkonwMessageVC.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/26.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "UnkonwMessageVC.h"
#import "UnknownModel.h"

@interface UnkonwMessageVC ()

@end

@implementation UnkonwMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UnknownModel *model = [UnknownModel new];
    [model performSelector:@selector(gogogo) withObject:@"666"];
}

@end
