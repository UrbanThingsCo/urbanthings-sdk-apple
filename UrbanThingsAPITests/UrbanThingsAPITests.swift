//
//  UrbanThingsAPITests.swift
//  UrbanThingsAPITests
//
//  Created by Mark Woollard on 25/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
import CoreLocation
@testable import UrbanThingsAPI

let ApiTestKey = "A VALID API KEY"

class UrbanThingsAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetImportSources() {
        
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")

        let _ = sut.sendRequest(UTImportSourcesRequest()) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetTransitStops() {
        
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitStopsRequest(center:CLLocationCoordinate2D(latitude:51.0, longitude:0.0), radius:5000)) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetPlacePoints() {
        
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTPlacePointsRequest(center:CLLocationCoordinate2D(latitude:51.0, longitude:0), radius:5000)) { data, error in
            if let data = data {
                for placePoint in data.placePoints {
                    print("\(placePoint.name)")
                }
            } else {
                print("\(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetPlacesList() {
        
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTPlacesListRequest(name:"Piccadilly", location:CLLocationCoordinate2D(latitude: 51, longitude: 0))) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetTransitRouteInfoByStopId() {
        
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "490009277Y")) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetAgency() {
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitAgencyRequest(agencyID: "TFL")) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }

    func testGetAgencies() {
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitAgenciesRequest(importSource: "ABC")) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetTrips() {
        let sut = UrbanThingsAPI(apiKey: ApiTestKey)

        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitTripsRequest(tripID:"BLT_T_1634523", includePolylines:true, includeStopCoordinates:true)) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }

    func testGetStopCalls() {
        let sut = UrbanThingsAPI(apiKey: ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitStopCallsRequest(stopID:"BLT:755")) { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testGetTripGroups() {
        let sut = UrbanThingsAPI(apiKey: ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID: "BLT_R_7867")) { (data, error) in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(60) { error in
        }
    }
    
    func testRTIReport() {
        let sut = UrbanThingsAPI(apiKey: ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTRealtimeReportRequest(stopID: "1400ZZBBSHF0")) { (data, error) in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(60) { error in
        }
    }

    func testRTIStopboard() {
        let sut = UrbanThingsAPI(apiKey: ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTRealtimeStopboardRequest(stopID: "1400ZZBBSHF0")) { (data, error) in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(60) { error in
        }
    }

    func testRTIResourceStatus() {
        let sut = UrbanThingsAPI(apiKey: ApiTestKey)
        
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTRealtimeResourceStatusRequest(stopID: "1400ZZBBSHF0")) { (data, error) in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(60) { error in
        }
    }
    
    func testGetDirections() {
        let sut = UrbanThingsAPI(apiKey:ApiTestKey)
        let expectation = expectationWithDescription("Waiting for API response")
        let _ = sut.sendRequest(UTDirectionsRequest(
            origin: TestPlacePoint(primaryCode: "SUNNYMEADS", name:"Sunnymeads Station", location: CLLocationCoordinate2D(latitude: 51.4702933, longitude:-0.5615487)),
            destination: TestPlacePoint(primaryCode: "OFFICE", name:"Office", location: CLLocationCoordinate2D(latitude: 51.5291205, longitude:-0.0802295))))
            { data, error in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
