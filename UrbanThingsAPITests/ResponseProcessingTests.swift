//
//  ResponseProcessingTests.swift
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
class ResponseProcessingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    
    }
    
    // MARK: TransitStops
    func testTransitStopsRequest() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TransitStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            if let result = try? self.compare(data, json: requestHandler.json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testTransitStopsRequestFailure() throws {
        // Passing incorrect JSON response should cause failure
        let requestHandler = try MockRequestHandler(jsonFile: "CallingAtStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }

    func testTransitStopsRequestPerformance() throws {
        // Passing incorrect JSON response should cause failure
        let requestHandler = try MockRequestHandler(jsonFile: "TransitStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            }
        }
    }

    // MARK: CallingAtStops
    func testCallingAtStopsRequest() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "CallingAtStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            if let result = try? self.compare(data, json: requestHandler.json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testCallingAtStopsRequestFailure() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TransitStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testCallingAtStopsRequestPerformance() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TripGroups")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            }
        }
    }
    
    // MARK: TripGroups
    func testTripGroupsRequest() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TripGroups")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            if let result = try? self.compare(data, json: requestHandler.json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testTripGroupsRequestFailure() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TransitStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }

    func testTripGroupsRequestPerformance() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TripGroups")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            }
        }
    }

    // MARK: Trips
    func testTripsRequest() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "Trips")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            if let result = try? self.compare(data, json: requestHandler.json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }

    func testTripsRequestFailure() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "TransitStops")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }

    func testTripsRequestPerformance() throws {
        
        let requestHandler = try MockRequestHandler(jsonFile: "Trips")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        let sut = UrbanThingsAPI(session: session, requestHandler: requestHandler)
        self.measureBlock {
            let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            }
        }
    }
    

}
