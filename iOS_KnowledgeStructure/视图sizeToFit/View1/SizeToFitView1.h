//
//  SizeToFitView1.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/7/1.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SizeToFitView1 : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

+ (instancetype)sizeToFitView1;

@end

NS_ASSUME_NONNULL_END
