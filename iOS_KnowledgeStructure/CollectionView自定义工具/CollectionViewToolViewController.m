//
//  CollectionViewToolViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/8/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CollectionViewToolViewController.h"
#import "CollectionViewTool.h"
#import <Masonry.h>

@interface CollectionViewToolViewController ()

@end

@implementation CollectionViewToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CollectionViewTool *tool = [CollectionViewTool collectionViewTool];
    [self.view addSubview:tool];
    
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(200);
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
