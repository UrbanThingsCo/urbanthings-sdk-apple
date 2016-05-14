//
//  StaticResponseProcessingTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 11/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import XCTest
import CoreLocation
@testable import UrbanThingsAPI

// These tests inject an instance of MockRequestHandler into the UrbanThingsAPI instance under test to provide
// local file of JSON as response to the request rather than needing a network call to be made and also risk change
// in data being processed.
class StaticResponseProcessingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    
    }
    
    func testImportSourcesRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTImportSourcesRequest()) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testImportSourcesRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("CallingAtStops")
        let _ = sut.sendRequest(UTImportSourcesRequest()) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testImportSourcesRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        self.measureBlock {
            let _ = sut.sendRequest(UTImportSourcesRequest()) { data, error in
            }
        }
    }
    

    // MARK: TransitStops
    func testTransitStopsRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("TransitStops")
        let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testTransitStopsRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("CallingAtStops")
        let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }

    func testTransitStopsRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("TransitStops")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            }
        }
    }

    // MARK: PlacePoints
    func testPlacePointsRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("PlacePoints")
        let _ = sut.sendRequest(UTPlacePointsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testPlacePointsRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("CallingAtStops")
        let _ = sut.sendRequest(UTPlacePointsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testPlacePointsRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("PlacePoints")
        self.measureBlock {
            let _ = sut.sendRequest(UTPlacePointsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            }
        }
    }
    
    // MARK: PlacePointsList
    func testPlacesListRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("PlacesList")
        let _ = sut.sendRequest(UTPlacesListRequest(name:"a", country:"gb")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testPlacesListRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("CallingAtStops")
        let _ = sut.sendRequest(UTPlacesListRequest(name:"a", country:"gb")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testPlacesListRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("PlacesList")
        self.measureBlock {
            let _ = sut.sendRequest(UTPlacesListRequest(name:"a", country:"gb")) { data, error in
            }
        }
    }

    // MARK: TransitRoutesByLineName
    func testTransitRoutesByLineNameRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("TransitRoutesByLineName")
        let _ = sut.sendRequest(UTTransitRoutesByLineNameRequest(lineName:"ABC", agencyID:"123")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testTransitRoutesByLineNameRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTTransitRoutesByLineNameRequest(lineName:"ABC", agencyID:"123")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testTransitRoutesByLineNameRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("TransitRoutesByLineName")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitRoutesByLineNameRequest(lineName:"ABC", agencyID:"123")) { data, error in
            }
        }
    }
    
    // MARK: TransitRoutesByImportSource
    func testTransitRoutesByImportSourceRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("TransitRoutesByImportSource")
        let _ = sut.sendRequest(UTTransitRoutesByImportSourceRequest(importSource:"TFL")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testTransitRoutesByImportSourceRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTTransitRoutesByImportSourceRequest(importSource:"TFL")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testTransitRoutesByImportSourceRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("TransitRoutesByImportSource")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitRoutesByImportSourceRequest(importSource:"TFL")) { data, error in
            }
        }
    }
    
    // MARK: CallingAtStops
    func testCallingAtStopsRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("CallingAtStops")
        let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testCallingAtStopsRequestFailure() throws {
        
        let (sut, _) = try getAPIInstanceAndJSON("TransitStops")
        let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testCallingAtStopsRequestPerformance() throws {
        
        let (sut, _) = try getAPIInstanceAndJSON("CallingAtStops")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            }
        }
    }
    
    // MARK: TransitAgencies
    func testTransitAgenciesRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("TransitAgencies")
        let _ = sut.sendRequest(UTTransitAgenciesRequest(importSource:"TFL")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testTransitAgenciesRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTTransitAgenciesRequest(importSource:"TFL")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testTransitAgenciesRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("TransitAgencies")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitAgenciesRequest(importSource:"TFL")) { data, error in
            }
        }
    }

    // MARK: TransitAgency
    func testTransitAgencyRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("TransitAgency")
        let _ = sut.sendRequest(UTTransitAgencyRequest(agencyID:"TFL")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json![0]) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testTransitAgencyRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTTransitAgencyRequest(agencyID:"TFL")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testTransitAgencyRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("TransitAgency")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitAgencyRequest(agencyID:"TFL")) { data, error in
            }
        }
    }

    // MARK: TripGroups
    func testTripGroupsRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("TripGroups")
        let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testTripGroupsRequestFailure() throws {
        
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }

    func testTripGroupsRequestPerformance() throws {
        
        let (sut, _) = try getAPIInstanceAndJSON("TripGroups")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            }
        }
    }

    // MARK: Trips
    func testTripsRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("Trips")
        let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testTripsRequestFailure() throws {
        
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }

    func testTripsRequestPerformance() throws {
        
        let (sut, _) = try getAPIInstanceAndJSON("Trips")
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            }
        }
    }
    

}
