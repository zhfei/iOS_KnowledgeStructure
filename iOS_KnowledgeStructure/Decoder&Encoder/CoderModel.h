//
//  CoderModel.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/28.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoderModel : NSObject <NSCoding>
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age sex:(NSString *)sex;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
