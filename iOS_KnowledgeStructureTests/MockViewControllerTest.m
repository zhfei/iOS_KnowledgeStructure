//
//  MockViewControllerTest.m
//  iOS_KnowledgeStructureTests
//
//  Created by 周飞 on 2019/3/6.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockViewController.h"
#import "OCMock.h"
#import "TwitterConnection.h"
#import "TweetView.h"
#import "Tweet.h"

@interface MockViewControllerTest : XCTestCase
@property (nonatomic, strong) MockViewController *mockVC;
@end

@implementation MockViewControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.mockVC = [MockViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testSum {
    XCTAssertEqual([self.mockVC sum:20 b:10], 30,@"错误.....");
}


- (void)testMockModelEqual {
    //实例对象
    MockModel *model = [MockModel new];
    model.myFriends = @"Tom";
    
    //处理 网络请求，业务对象
    //生成Mock对象，并设置返回值
    id modelMock =OCMClassMock([MockModel class]);
    OCMStub([modelMock myFriends]).andReturn(@"Tom");

    //断言
    XCTAssertEqualObjects([model myFriends], [modelMock myFriends],@"不相等。。。。");
}




- (void)testDisplaysTweetsRetrievedFromConnection{
    //模拟网络请求类
    id mockConn = OCMClassMock([TwitterConnection class]);
    self.mockVC.connection = mockConn;
    
    //模拟网络请求结果
    Tweet *t1 = [Tweet new];
    t1.userName = @"Tom";
    Tweet *t2 = [Tweet new];
    t2.userName = @"Cat";
    NSArray *results = @[t1,t2];
    OCMStub([mockConn fetchTweets]).andReturn(results);
    
    //模拟一个View类
    TweetView *tweet = OCMClassMock([TweetView class]);
    self.mockVC.tweetView = tweet;
    
    //下面的方法会触发VC内[mockConn fetchTweets]方法调用，同时调用内部的[tweetView addTweet:t];方法
    [self.mockVC updateTweetView];
    
    //------------下面是验证[tweetView addTweet:t]方法是否被结果数组调用了------------------
    
    OCMVerify([tweet addTweet:t1]);
    OCMVerify([tweet addTweet:t2]);
    //[OCMArg any]匹配任意参数值
    OCMVerify([tweet addTweet:[OCMArg any]]);
}

//精准mock的TEST， 出错的话会抛异常
- (void)testStrictMock3{
    id tweetV = OCMClassMock([TweetView class]);
    OCMExpect([tweetV addTweet:[OCMArg isNotNil]]);
    OCMStub([tweetV addTweet:[OCMArg isNotNil]]);
    
    Tweet *t1 = [Tweet new];
    t1.userName = @"Tom";
    [tweetV addTweet:t1];
    
//    OCMVerifyAll(tweet);
    OCMVerifyAll(tweetV);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
