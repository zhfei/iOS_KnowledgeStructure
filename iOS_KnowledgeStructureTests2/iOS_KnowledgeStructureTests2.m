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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
