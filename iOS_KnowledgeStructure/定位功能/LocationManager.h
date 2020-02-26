//
//  LocationManager.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/26.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BottomComponentLib/BCMacro.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LocationBlock)(NSString *location);

@interface LocationManager : NSObject
SingletonH(LocationManager)
- (void)startLocation;
- (void)startLocation:(LocationBlock)block;
@end

NS_ASSUME_NONNULL_END
