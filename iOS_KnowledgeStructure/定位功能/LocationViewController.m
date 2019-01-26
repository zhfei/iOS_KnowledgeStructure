//
//  LocationViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/26.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationManager.h"
#import <BottomComponentLib/ZHFAlertControlle.h>

@interface LocationViewController ()

@end

@implementation LocationViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Getter, Setter

#pragma mark - Event
- (IBAction)clickAction:(UIButton *)sender {
    [[LocationManager sharedLocationManager] startLocation:^(NSString * _Nonnull location) {
        NSLog(@"当前地址为：%@",location);
        
        [ZHFAlertControlle showWithTitle:@"当前地址" message:location btn1Title:@"确定" btn1Handle:^(UIAlertAction * _Nullable action) {
            
        }];
    }];
    
    
}
#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupData {
    
}

- (void)setupUI {
    
}

- (void)resetData {
    
}

- (void)resetUI {
    
}

#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject

@end
