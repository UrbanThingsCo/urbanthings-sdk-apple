//
//  RealtimeAdapterTests.m
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 20/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitTests-Swift.h"
#import <UIKit/UIKit.h>
@import UTAPIObjCAdapter;

@interface RealtimeAdapterTests : XCTestCase

@end

@implementation RealtimeAdapterTests

- (void)testRTIReport {
    NSObject<TransitStopRTIResponse> *sut = [RealtimeAdapterTestsSwift getRTIReport];
    XCTAssertNotNil(sut);
}

- (void)testRTIStopboard {
    NSObject<StopBoardResponse> *sut = [RealtimeAdapterTestsSwift getRTIStopboard];
    XCTAssertNotNil(sut);
}

- (void)testResourceStatus {
    NSObject<ResourceStatus> *sut = [RealtimeAdapterTestsSwift getRTIStatus];
    XCTAssertNotNil(sut);
}

- (void)testResourceStatuses {
    NSArray<NSObject<ResourceStatus>*> *sut = [RealtimeAdapterTestsSwift getRTIStatuses];
    XCTAssertNotNil(sut);
}

- (void)testRTIReportPerformance {
    [self measureBlock:^{
        [RealtimeAdapterTestsSwift getRTIReport];
    }];
}

- (void)testStopBoardPerformance {
    [self measureBlock:^{
        [RealtimeAdapterTestsSwift getRTIStopboard];
    }];
}

- (void)testResourceStatusPerformance {
    [self measureBlock:^{
        [RealtimeAdapterTestsSwift getRTIStatus];
    }];
}

- (void)testResourceStatusesPerformance {
    [self measureBlock:^{
        [RealtimeAdapterTestsSwift getRTIStatuses];
    }];
}

@end

