//
//  DirectionsAdapterRequest.m
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 20/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitTests-Swift.h"
#import <UIKit/UIKit.h>
@import UTAPIObjCAdapter;

@interface DirectionsAdapterTests : XCTestCase

@end

@implementation DirectionsAdapterTests

- (void)testDirections {
    NSObject<DirectionsResponse> *sut = [DirectionsAdapterTestsSwift getDirections];
    XCTAssertNotNil(sut);
}

- (void)testDirectionsPerformance {
    [self measureBlock:^{
        [DirectionsAdapterTestsSwift getDirections];
    }];
}

@end