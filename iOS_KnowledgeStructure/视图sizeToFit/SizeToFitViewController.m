//
//  SizeToFitViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/7/1.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "SizeToFitViewController.h"
#import "SizeToFitView1.h"

@interface SizeToFitViewController ()
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (strong, nonatomic) SizeToFitView1 *sfView;
@end

@implementation SizeToFitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    }

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.sfView];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.sfView.center = self.view.center;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGRect oldRect = self.sfView.frame;
    
//    self.sfView.titleLabel.text = [self.sfView.titleLabel.text stringByAppendingString:@"\n工业和信息化部办公厅近日印发"];
//    self.sfView.desLabel.text = [self.sfView.desLabel.text stringByAppendingString:@"\n通过集中开展数据安全合规性评估、专项治理和监督检查，督促基础电信企业"];
//    self.sfView.hintLabel.text = [self.sfView.hintLabel.text stringByAppendingString:@"\n2019年10月底前完成全部基础电信企业（含专业公司）"];
//
//    CGRect newRect = self.sfView.frame;
//
//    //混合容器自适应高度解决方案
////    [self.sfView setNeedsUpdateConstraints];
////    [self.sfView updateConstraintsIfNeeded];
//    [self.sfView setNeedsLayout];
//    [self.sfView layoutIfNeeded];
//
//    CGFloat height = [self.sfView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//
//    [UIView animateWithDuration:0.5 animations:^{
//        self.sfView.frame = CGRectMake(0, 0, 320, height);
//    }];
//
//    //单个label
////    [self.sfView.hintLabel sizeToFit];
//
//    NSLog(@"oldRect:%@ -- newRect:%@",NSStringFromCGRect(oldRect),NSStringFromCGRect(newRect));
    
    if (![self.detailBtn currentAttributedTitle]) {
        NSMutableAttributedString*settingStr = [[NSMutableAttributedString alloc] initWithString:@"去设置"];
        NSRange strRange = {0,[settingStr length]};
        [settingStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        
        [self.detailBtn setAttributedTitle:settingStr forState:UIControlStateNormal];

    } else {
        [self.detailBtn setAttributedTitle:nil forState:UIControlStateNormal];
    }
    
    
}



- (SizeToFitView1 *)sfView {
    if (!_sfView) {
        _sfView = [SizeToFitView1 sizeToFitView1];
    }
    return _sfView;
}

@end
