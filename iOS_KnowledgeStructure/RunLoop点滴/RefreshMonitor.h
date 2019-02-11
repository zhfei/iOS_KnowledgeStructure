//
//  RefreshMonitor.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/8.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BottomComponentLib/Macro.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefreshMonitor : NSObject
SingletonH(RefreshMonitor)
- (void)startObserver;
@end

NS_ASSUME_NONNULL_END
