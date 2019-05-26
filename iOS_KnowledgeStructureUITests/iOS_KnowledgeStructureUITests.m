//
//  iOS_KnowledgeStructureUITests.m
//  iOS_KnowledgeStructureUITests
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LayoutConstraintViewController.h"

@interface iOS_KnowledgeStructureUITests : XCTestCase
@property (nonatomic, strong) LayoutConstraintViewController *lcVC;
@end

@implementation iOS_KnowledgeStructureUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    self.lcVC = [LayoutConstraintViewController new];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPushVC {
    XCUIElementQuery *tablesQuery = [[XCUIApplication alloc] init].tables;
    [tablesQuery.staticTexts[@"ScrollView\u7684\u5e94\u7528"] swipeUp];
    [tablesQuery.staticTexts[@"\u624b\u7801\u5e03\u5c40"] tap];
}

- (void)testLabelHint {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app/*@START_MENU_TOKEN@*/.staticTexts[@"titleLabele"]/*[[".staticTexts[@\"\\u5b50\\u5185\\u5bb9\"]",".staticTexts[@\"titleLabele\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app/*@START_MENU_TOKEN@*/.staticTexts[@"contextLabel"]/*[[".staticTexts[@\"\\u5bb9\\u5668\\u5185\\u5bb9\"]",".staticTexts[@\"contextLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
}

- (void)testButtonTap {

}

////获取当前的window和所有控件
//XCUIApplication *app = [[XCUIApplication alloc] init];
//XCUIElement *windowEle = app.windows.allElementsBoundByIndex[0];
//XCUIElement *emptyBtn = app.buttons[@"EmptyButton"];
//
////是否存在
//NSPredicate *predice =[NSPredicate predicateWithFormat:@"exists == true"];
//[self expectationForPredicate:predice evaluatedWithObject:emptyBtn handler:nil];
//
//if (![self canOperateElement:emptyBtn]) {
//    [emptyBtn pressForDuration:2 thenDragToElement:emptyBtn];
//} else {
//    [emptyBtn tap];
//}
//
//[self waitForExpectationsWithTimeout:5.0 handler:nil];
//

- (void)startHintLabel {
    //获取当前的window和所有控件
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *windowEle = app.windows.allElementsBoundByIndex[0];
    XCUIElement *emptyBtn = app.buttons[@"EmptyButton"];
    
    for (int i = 0; i < 10; i++) {
        if ([self canOperateElement:emptyBtn]) {
            [emptyBtn pressForDuration:2.0];
        }
    }
}

- (BOOL)canOperateElement:(XCUIElement *)element {
    if (element != nil) {
        if (element.exists && element.hittable) {
            return NO;
        }
    }
    return NO;
}

- (void)testAsynOperation {
    XCTestExpectation *exp = [self expectationWithDescription:@"期望"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    [self waitForExpectations:@[exp] timeout:5.0];
}

@end
