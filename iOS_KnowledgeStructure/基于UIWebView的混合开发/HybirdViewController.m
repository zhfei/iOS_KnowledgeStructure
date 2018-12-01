//
//  HybirdViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/12/1.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "HybirdViewController.h"

@interface HybirdViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)btnAction:(UIButton *)sender;
- (IBAction)loadAction:(UIButton *)sender;

@end

@implementation HybirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)btnAction:(UIButton *)sender {
}

- (IBAction)loadAction:(UIButton *)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https:www.baidu.com"]];
    [self.webView loadRequest:request];
}
@end
