//
//  ZFAlertView.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/23.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFAlertView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^BtnTapBlock)();

@protocol ZFAlertViewDelegate <NSObject>
- (void)alertViewDelegate:(ZFAlertView *)alertView sureAction:(UIButton *)sender;
- (void)alertViewDelegate:(ZFAlertView *)alertView cancleAction:(UIButton *)sender;
- (void)alertViewDelegate:(ZFAlertView *)alertView endEdit:(UITextView *)textView;

@end

@interface ZFAlertView : UIView
@property (nonatomic, weak) id<ZFAlertViewDelegate> delegate;
+ (ZFAlertView *)alertView;
@end

NS_ASSUME_NONNULL_END
