//
//  iOS_KnowledgeStructureTests2.m
//  iOS_KnowledgeStructureTests2
//
//  Created by zhoufei on 2019/5/23.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface iOS_KnowledgeStructureTests2 : XCTestCase
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation iOS_KnowledgeStructureTests2

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _session = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//需要等待网络返回才能验证失败，比较耗时间
- (void)testAsynNetWork {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?media=music&entity=song&term=abba"];
    XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"Status code: 200"];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            XCTFail(@"error:%@",error.description);
            return ;
        } else if (response && [(NSHTTPURLResponse *)response statusCode] > 0) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode == 200) {
                //期望满足了
                [exp fulfill];
            } else {
                XCTFail(@"statusCode: %ld",(long)statusCode);
            }
        }
    }];
    
    [task resume];
    
    [[XCTWaiter new] waitForExpectations:@[exp] timeout:5];
}

//函数调用结束就可以判断
- (void)testCallMethodComplete {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?media=music&entity=song&term=abba"];
    XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"Completion handler invoked"];
    
     __block NSInteger statusCode;
    NSError *responseError;
    
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        statusCode = [(NSHTTPURLResponse *)response statusCode];
        [exp fulfill];
    }];
    
    [task resume];
    [[XCTWaiter new] waitForExpectations:@[exp] timeout:5];
    
    XCTAssertNil(responseError);
    XCTAssertEqual(statusCode, 200);

}


#pragma mark - 性能测试
/*
 1.性能测试方法
 2.设置baseline值
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        sleep(arc4random_uniform(3));
    }];
}

- (void)testPerformanceExample2 {
    
    // This is an example of a performance test case.
    [self measureMetrics:@[@"3",@"2",@"1"] automaticallyStartMeasuring:YES forBlock:^{
        
        //1.[self doBeforeSomeThing]
        
        //2.在此方法前，做提前准备工作，而这些准备工作是不会进行性能统计的。
        [self startMeasuring];
        
        //3.[self myTargetFunction]
        
        
        //4.在此方法后，做一写收尾工作，而这些准备工作是不会进行性能统计的。
        [self stopMeasuring];
        
        //5.[self doAfterSomeThing]
        
    }];
}

#pragma mark - 异步测试
// !!!: XCTestExpectation
/*
 1.步骤：新建期望，等待期望被履行，履行期望
 */
- (void)testAsyncClassFunction {
    XCTestExpectation *expClass = [self expectationWithDescription:@"期望描述（测试类持有）"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expClass fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
    XCTAssertTrue(1,@"测试类持有的期望——满足条件失败");
    
}

- (void)testAsyncFunction {
    XCTestExpectation *expVar = [[XCTestExpectation alloc] initWithDescription:@"期望描述（自己局部变量持有）"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expVar fulfill];
    });
    
    [self waitForExpectations:@[expVar] timeout:10];
    
    XCTAssertTrue(1,@"局部变量持有持有的期望——满足条件失败");
}


// !!!: XCTWaiter - XCTWaiterDelegate
- (void)testWaiter {
    XCTWaiter *waiter = [[XCTWaiter alloc] initWithDelegate:self];
    
    XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"局部变量期望"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    XCTWaiterResult result = [waiter waitForExpectations:@[exp] timeout:5.0 enforceOrder:NO];
    
    XCTAssertTrue(result == XCTWaiterResultCompleted, @"失败：%ld",(long)result);
}

//waiter的delegate

- (void)waiter:(XCTWaiter *)waiter didFulfillInvertedExpectation:(XCTestExpectation *)expectation {
    //期望被标记成反转，倒置，则调用。
}

- (void)waiter:(XCTWaiter *)waiter didTimeoutWithUnfulfilledExpectations:(NSArray<XCTestExpectation *> *)unfulfilledExpectations {
    //期望超时
}

- (void)waiter:(XCTWaiter *)waiter fulfillmentDidViolateOrderingConstraintsForExpectation:(XCTestExpectation *)expectation requiredExpectation:(XCTestExpectation *)requiredExpectation {
    //期望未按规定的顺序执行
}

- (void)nestedWaiter:(XCTWaiter *)waiter wasInterruptedByTimedOutWaiter:(XCTWaiter *)outerWaiter {
    //被打断，在超时和履行期望之前
}


#pragma mark - 综合使用
//将一个复杂逻辑拆分成n个部分
- (void)testActivities {
    [XCTContext runActivityNamed:@"step1" block:^(id<XCTActivity>  _Nonnull activity) {
        XCTestExpectation *exp = [self expectationWithDescription:@"局部期望1"];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [exp fulfill];
        });
    }];
    
    [XCTContext runActivityNamed:@"step2" block:^(id<XCTActivity>  _Nonnull activity) {
        XCTestExpectation *exp = [self expectationWithDescription:@"局部期望2"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [exp fulfill];
        });
    }];
    
    [self waitForExpectationsWithTimeout:4 handler:^(NSError * _Nullable error) {
        NSLog(@"error:%@",error);
    }];
}



@end
