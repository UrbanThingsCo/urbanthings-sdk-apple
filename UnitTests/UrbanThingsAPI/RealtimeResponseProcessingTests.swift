//
//  RealtimeResponseProcessingTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 14/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
import CoreLocation
@testable import UTAPI

// These tests inject an instance of MockRequestHandler into the UrbanThingsAPI instance under test to provide
// local file of JSON as response to the request rather than needing a network call to be made and also risk change
// in data being processed.
class RealtimeResponseProcessingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testRTIReportRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("RealtimeReport")
        let _ = sut.sendRequest(UTRealtimeReportRequest(stopID:"123")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testRTIReportRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSource")
        let _ = sut.sendRequest(UTRealtimeReportRequest(stopID:"123")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testRTIReportRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("RealtimeReport")
        self.measureBlock {
            let _ = sut.sendRequest(UTRealtimeReportRequest(stopID:"123")) { data, error in
            }
        }
    }
    
    func testRTIStopboardRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("RealtimeStopBoard")
        let _ = sut.sendRequest(UTRealtimeStopboardRequest(stopID:"123")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testRTIStopboardRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSource")
        let _ = sut.sendRequest(UTRealtimeStopboardRequest(stopID:"123")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testRTIStopboardRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("RealtimeStopBoard")
        self.measureBlock {
            let _ = sut.sendRequest(UTRealtimeStopboardRequest(stopID:"123")) { data, error in
            }
        }
    }
    
    func testRTIStatusRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("RealtimeStatus")
        let _ = sut.sendRequest(UTRealtimeResourceStatusRequest(stopID:"123")) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json![0]) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testRTIStatusRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSource")
        let _ = sut.sendRequest(UTRealtimeResourceStatusRequest(stopID:"123")) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testRTIStatusRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("RealtimeStatus")
        self.measureBlock {
            let _ = sut.sendRequest(UTRealtimeResourceStatusRequest(stopID:"123")) { data, error in
            }
        }
    }

    func testRTIStatusesRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("RealtimeStatuses")
        let _ = sut.sendRequest(UTRealtimeResourcesStatusRequest(stopIDs:["123"])) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testRTIStatusesRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(UTRealtimeResourcesStatusRequest(stopIDs:["123"])) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testRTIStatusesRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("RealtimeStatuses")
        self.measureBlock {
            let _ = sut.sendRequest(UTRealtimeResourcesStatusRequest(stopIDs:["123"])) { data, error in
            }
        }
    }

}

