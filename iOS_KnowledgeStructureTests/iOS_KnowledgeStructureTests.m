//
//  iOS_KnowledgeStructureTests.m
//  iOS_KnowledgeStructureTests
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitTestViewController.h"

@interface iOS_KnowledgeStructureTests : XCTestCase
@property (nonatomic, strong) UnitTestViewController *unitVC;
@end

@implementation iOS_KnowledgeStructureTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    self.unitVC = [[UnitTestViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.unitVC = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testAdd {
    NSInteger sum = [self.unitVC add:10 b:10];
    
    XCTAssert(sum == 10, @"计算错误...");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
