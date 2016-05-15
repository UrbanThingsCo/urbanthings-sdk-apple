//
//  DirectionsResponseProcessingTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 14/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
import CoreLocation
@testable import UrbanThingsAPI

private let directionsRequest = UTDirectionsRequest(
    origin: TestPlacePoint(primaryCode: "SUNNYMEADS", name:"Sunnymeads Station", location: CLLocationCoordinate2D(latitude: 51.4702933, longitude:-0.5615487)),
    destination: TestPlacePoint(primaryCode: "OFFICE", name:"Office", location: CLLocationCoordinate2D(latitude: 51.5291205, longitude:-0.0802295)))

class DirectionsResponseProcessingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDirectionsRequest() throws {
        
        let (sut, json) = try getAPIInstanceAndJSON("Directions")
        let _ = sut.sendRequest(directionsRequest) { data, error in
            XCTAssertNil(error)
            if let result = try? self.compare(data, json: json) {
                XCTAssertTrue(result)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testDirectionsRequestFailure() throws {
        let (sut, _) = try getAPIInstanceAndJSON("ImportSources")
        let _ = sut.sendRequest(directionsRequest) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testDirectionsRequestPerformance() throws {
        let (sut, _) = try getAPIInstanceAndJSON("Directions")
        self.measureBlock {
            let _ = sut.sendRequest(directionsRequest) { data, error in
            }
        }
    }
}
