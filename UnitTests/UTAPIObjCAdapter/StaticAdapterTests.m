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

@interface StaticAdapterTests : XCTestCase

@end

@implementation StaticAdapterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testImportSources {
    NSArray<NSObject<ImportSource>*> *sut = [StaticAdapterTestsSwift getImportSources];
    XCTAssertNotNil(sut);
}

- (void)testTransitStop {
    NSArray<NSObject<TransitStop>*> *sut = [StaticAdapterTestsSwift getTransitStops];
    XCTAssertNotNil(sut);
}

- (void)testPlacePoints {
    NSObject<PlacePointList> *sut = [StaticAdapterTestsSwift getPlacePoints];
    XCTAssertNotNil(sut);
}

- (void)testPlacesList {
    NSObject<PlacePointList> *sut = [StaticAdapterTestsSwift getPlacesList];
    XCTAssertNotNil(sut);
}

- (void)testTransitRoutesByLineName {
    NSArray<NSObject<TransitDetailedRouteInfo>*> *sut = [StaticAdapterTestsSwift getTransitRoutesByLineName];
    XCTAssertNotNil(sut);
}

- (void)testTransitRoutesByImportSource {
    NSArray<NSObject<TransitDetailedRouteInfo>*> *sut = [StaticAdapterTestsSwift getTransitRoutesByImportSource];
    XCTAssertNotNil(sut);
}

- (void)testTransitRoutesCallingAtStops {
    NSArray<NSObject<TransitDetailedRouteInfo>*> *sut = [StaticAdapterTestsSwift getTransitRoutesCallingAtStops];
    XCTAssertNotNil(sut);
}

- (void)testTransitAgencies {
    NSArray<NSObject<TransitAgency>*> *sut = [StaticAdapterTestsSwift getTransitAgencies];
    XCTAssertNotNil(sut);
}

- (void)testTransitAgency {
    NSObject<TransitAgency> *sut = [StaticAdapterTestsSwift getTransitAgency];
    XCTAssertNotNil(sut);
}

- (void)testTripGroups {
    NSArray<NSObject<TransitTripCalendarGroup>*> *sut = [StaticAdapterTestsSwift getTripGroups];
    XCTAssertNotNil(sut);
}

- (void)testTrips {
    NSArray<NSObject<TransitTrip>*> *sut = [StaticAdapterTestsSwift getTrips];
    XCTAssertNotNil(sut);
}

- (void)testImportSourcesPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getImportSources];
    }];
}

- (void)testTransitStopsPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTransitStops];
    }];
}

- (void)testPlacePointsPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getPlacePoints];
    }];
}

- (void)testPlacesListPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getPlacesList];
    }];
}

- (void)testTransitRoutesByImportSourcePerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTransitRoutesByImportSource];
    }];
}

- (void)testTransitRoutesCallingAtStopsPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTransitRoutesCallingAtStops];
    }];
}

- (void)testTransitAgenciesPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTransitAgencies];
    }];
}

- (void)testTransitAgencyPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTransitAgency];
    }];
}

- (void)testTripGroupsPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTripGroups];
    }];
}

- (void)testTripsPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [StaticAdapterTestsSwift getTrips];
    }];
}


@end
