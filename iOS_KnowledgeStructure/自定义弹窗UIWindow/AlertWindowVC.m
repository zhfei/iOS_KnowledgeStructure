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
#import <BottomComponentLib/ZHFAlertControlle.h>
#import "ZFAlertViewController.h"

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
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"OK...");
//    }];
//    [alert addAction:ac];
//
//    [self presentViewController:alert animated:YES completion:nil];
    
    
    NSArray *arr = @[@(UIWindowLevelNormal),@(UIWindowLevelAlert),@(UIWindowLevelStatusBar)];
    NSLog(@"arr: %@",arr);
    
    [self showAlertViewController];
//    [self showZHFAlertController];
}

- (void)showProgressWindow {
    ProgressWindow *window = [ProgressWindow sharedProgressWindow];
    window.hidden = NO;
//    ProgressViewController *pvc = [ProgressViewController new];
    ZFAlertViewController *pvc = [ZFAlertViewController new];
    
    
    [window.rootViewController presentViewController:pvc animated:NO completion:nil];
}

- (void)showAlertViewController {
    ZFAlertViewController *alertVC = [ZFAlertViewController alertViewController:ZFAlertTypeInput];
    [alertVC showAlertVC];
}

- (void)showZHFAlertController {
    [ZHFAlertControlle showWithTitle:@"标题" message:@"内容" btn1Title:@"子标题" btn1Handle:^(UIAlertAction * _Nullable action) {
        NSLog(@"点击了。。");
    }];
}

@end
