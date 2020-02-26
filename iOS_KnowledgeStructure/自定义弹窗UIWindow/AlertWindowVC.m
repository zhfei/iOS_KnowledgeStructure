//
//  AlertWindowVC.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "AlertWindowVC.h"
#import "ProgressWindow.h"
#import "ProgressViewController.h"
#import <BottomComponentLib/BCAlertController.h>
#import "BCAlertController.h"

@interface AlertWindowVC ()
@property (nonatomic, strong)UIWindow *window;
@end

@implementation AlertWindowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK...");
    }];
    [alert addAction:ac];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消...");
    }];
    [alert addAction:cancle];
    
    UIAlertAction *cancle2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"第三者...");
    }];
    [alert addAction:cancle2];
    
    
    UIColor *color = [UIColor lightGrayColor];
    [cancle setValue:color forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
    
    
//    NSArray *arr = @[@(UIWindowLevelNormal),@(UIWindowLevelAlert),@(UIWindowLevelStatusBar)];
//    NSLog(@"arr: %@",arr);
//
//    [self showAlertViewController];
//    [self showBCAlertControllerr];
}

- (void)showProgressWindow {
    ProgressWindow *window = [ProgressWindow sharedProgressWindow];
    window.hidden = NO;
//    ProgressViewController *pvc = [ProgressViewController new];
    BCAlertController *pvc = [BCAlertController new];
    
    
    [window.rootViewController presentViewController:pvc animated:NO completion:nil];
}

- (void)showAlertViewController {
    BCAlertController *alertVC = [BCAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC showAlertVC];
}

- (void)showBCAlertControllerr {
    [BCAlertController showWithTitle:@"标题" message:@"内容" btn1Title:@"子标题" btn1Handle:^(UIAlertAction * _Nullable action) {
        NSLog(@"点击了。。");
    }];
}

@end
