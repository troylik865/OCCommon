//
//  DatabaseTests.m
//  DatabaseTests
//
//  Created by 李彬 on 15/7/15.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface DatabaseTests : XCTestCase

@end

@implementation DatabaseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

@end
