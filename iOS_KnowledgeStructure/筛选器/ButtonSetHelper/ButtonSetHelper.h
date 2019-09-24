//
//  ButtonSetHelper.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/9/24.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ButtonSetHelper : NSObject
/**
 为contextView批量添加按钮

 @param contextView 容器view
 @param titles 按钮标题
 */
- (void)updateContextView:(UIView *)contextView buttonTitles:(NSArray<NSString *>*)titles;
@end

NS_ASSUME_NONNULL_END
