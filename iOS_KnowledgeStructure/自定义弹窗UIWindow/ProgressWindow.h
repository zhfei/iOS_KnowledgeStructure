//
//  ProgressWindow.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/3.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressWindow : UIWindow <NSCopying>
+ (instancetype)sharedProgressWindow;
@end

NS_ASSUME_NONNULL_END
