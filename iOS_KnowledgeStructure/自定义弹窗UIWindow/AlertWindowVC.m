//
//  AlertWindowVC.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "AlertWindowVC.h"

@interface AlertWindowVC ()

@end

@implementation AlertWindowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK...");
    }];
    [alert addAction:ac];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    NSArray *arr = @[@(UIWindowLevelNormal),@(UIWindowLevelAlert),@(UIWindowLevelStatusBar)];
    NSLog(@"arr: %@",arr);
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
