//
//  InputAlertViewController.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/23.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZFAlertType) {
    ZFAlertTypeInput = 0,
};


NS_ASSUME_NONNULL_BEGIN

@interface ZFAlertViewController : UIViewController

+ (ZFAlertViewController *)alertViewController:(ZFAlertType)type;
- (void)showAlertVC;
@end

NS_ASSUME_NONNULL_END
