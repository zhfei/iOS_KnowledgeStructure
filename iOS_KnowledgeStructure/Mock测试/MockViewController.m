//
//  MockViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/6.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "MockViewController.h"

@implementation MockModel
+ (instancetype)mockModel:(NSString *)name age:(NSUInteger)age {
    MockModel *model = [MockModel new];
    model.name = name;
    model.age = age;
    return model;
}
@end

@interface MockViewController ()

@end

@implementation MockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)updateTweetView{
    
    NSArray *tweets = [_connection fetchTweets];
    if (tweets != nil) {
        for (Tweet *t in tweets){
            [_tweetView addTweet:t];
        }
    } else {
        /* handle error cases */
    }
}

- (void)updateTweetView2{
    
    NSArray *tweets = [TwitterConnection fetchTweets2];
    if (tweets != nil) {
        for (Tweet *t in tweets){
            [_tweetView addTweet:t];
        }
    } else {
        /* handle error cases */
    }
}





- (NSInteger)sum:(NSInteger)a b:(NSInteger)b {
    return a+b;
}

- (BOOL)mockModelEqual:(MockModel *)model1 model2:(MockModel *)model2 {
    if (model1.age == model2.age && model1.name == model2.name) {
        return YES;
    }
    return NO;
}

@end
