//
//  RuntimePerson2+Associated.h
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson2.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^CodingCallBack)();

@interface RuntimePerson2 (Associated)
@property (nonatomic, strong) NSNumber *associatedBust; // 胸围
@property (nonatomic, copy) CodingCallBack associatedCallBack;  // 写代码


@end

NS_ASSUME_NONNULL_END
