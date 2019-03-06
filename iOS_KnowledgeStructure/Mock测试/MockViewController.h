//
//  MockViewController.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/6.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterConnection.h"
#import "TweetView.h"

@interface MockModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, copy) NSString *myFriends;
+ (instancetype)mockModel:(NSString *)name age:(NSUInteger)age;

@end


NS_ASSUME_NONNULL_BEGIN

@interface MockViewController : UIViewController
@property(nonatomic, strong)TwitterConnection *connection;
@property(nonatomic, strong)TweetView         *tweetView;

- (void)updateTweetView;

- (void)updateTweetView2;



- (NSInteger)sum:(NSInteger)a b:(NSInteger)b;
- (BOOL)mockModelEqual:(MockModel *)model1 model2:(MockModel *)model2;
@end

NS_ASSUME_NONNULL_END
