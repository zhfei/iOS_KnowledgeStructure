//
//  VariableParamFunction.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2020/2/3.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VariableParamFunction : NSObject
- (void)demoSelector:(NSString *)fmt param:(NSString *)param1, ... NS_REQUIRES_NIL_TERMINATION;


@end

NS_ASSUME_NONNULL_END
