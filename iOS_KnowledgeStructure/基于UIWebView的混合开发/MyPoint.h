//
//  MyPoint.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/21.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

//遵守了JSExport协议的对象，就可以直接将对象传递给JavaScriptCore,js就可以调用自己的对象一样调用OC的对象了
@protocol MyPointExportProtocol <JSExport>
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;

- (NSString *)description;
+ (instancetype)makePointX:(float)x y:(float)y;

//建立js方法与OC方法对应
JSExportAs(makePoint,
           + (instancetype)makePointX:(float)x y:(float)y
           );
@end

@interface MyPoint : NSObject <MyPointExportProtocol>

@end

NS_ASSUME_NONNULL_END
