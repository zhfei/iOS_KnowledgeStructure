//
//  LayoutConstraintSubVC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LayoutConstraintSubVC.h"

@interface LayoutConstraintSubVC ()

@end

@implementation LayoutConstraintSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //下面熟悉默认为YES,当属性为YES则系统会将AutoresizingMask转化成Auto Layout
    //这样的话，系统的会和自己添加的产生冲突
    //另外：如果在xib中使用Auto Layout，则属性会被关闭
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
}



@end
