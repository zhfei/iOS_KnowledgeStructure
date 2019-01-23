//
//  ZFAlertView.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/23.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ZFAlertView.h"

@interface ZFAlertView ()<UITextViewDelegate>

@end

@implementation ZFAlertView
+ (ZFAlertView *)alertView {
    ZFAlertView *header = [[NSBundle mainBundle] loadNibNamed:@"ZFAlertView" owner:nil options:nil][0];
    return header;
}
- (IBAction)sureAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(alertViewDelegate:sureAction:)]) {
        [self.delegate alertViewDelegate:self sureAction:sender];
    }
}
- (IBAction)cancleAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(alertViewDelegate:cancleAction:)]) {
        [self.delegate alertViewDelegate:self cancleAction:sender];
    }
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(alertViewDelegate:endEdit:)]) {
        [self.delegate alertViewDelegate:self endEdit:textView];
    }
}



@end
