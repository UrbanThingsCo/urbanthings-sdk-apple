//
//  ImportSourceAdapterTests.m
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 18/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitTests-Swift.h"
#import <UIKit/UIKit.h>
@import UTAPIObjCAdapter;

@interface ImportSourceAdapterTests : XCTestCase

@end

@implementation ImportSourceAdapterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testImportSource {
    NSArray<id<ImportSource>> *sut = [TestImportSource getImportSources];
    [sut enumerateObjectsUsingBlock:^(id<ImportSource> importSource, NSUInteger index, BOOL *stop) {
        NSString *s = [importSource name];
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
