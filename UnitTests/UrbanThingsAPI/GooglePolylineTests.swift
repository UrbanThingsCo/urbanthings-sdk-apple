//
//  GooglePolylineTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 12/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
import MapKit
@testable import UTAPI

let testString = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
let testBadString = "_p~iF~ps|0_ulLnnqC_mqNvxq`@"

let testCoords = [
    CLLocationCoordinate2D(latitude:38.5, longitude:-120.2),
    CLLocationCoordinate2D(latitude:40.7, longitude:-120.95),
    CLLocationCoordinate2D(latitude:43.252, longitude:-126.453)
]

class GooglePolylineTests: XCTestCase {

    func testDecodingToSequence() throws {
        let sut = testString
        var index = 0
        for point in try sut.asCoordinateSequence() {
            XCTAssertEqualWithAccuracy(testCoords[index].latitude, point.latitude, accuracy: 0.001)
            XCTAssertEqualWithAccuracy(testCoords[index].longitude, point.longitude, accuracy: 0.001)
            index += 1
        }
        XCTAssertEqual(testCoords.count, index)
    }

    func testDecodingToArray() throws {
        let sut = testString
        var index = 0
        for point in try sut.asCoordinateArray() {
            XCTAssertEqualWithAccuracy(testCoords[index].latitude, point.latitude, accuracy: 0.001)
            XCTAssertEqualWithAccuracy(testCoords[index].longitude, point.longitude, accuracy: 0.001)
            index += 1
        }
        XCTAssertEqual(testCoords.count, index)
    }

    @available(tvOS 9.2, *)
    func testDecodingToMKPolyline() throws {
        let sut = testString
        let mkPolyline = try sut.asMKPolyline()
        XCTAssertEqual(testCoords.count, mkPolyline.pointCount)
        let pointer = mkPolyline.points()
        for index in (0..<testCoords.count) {
            let point = MKCoordinateForMapPoint(pointer[index])
            XCTAssertEqualWithAccuracy(testCoords[index].latitude, point.latitude, accuracy: 0.001)
            XCTAssertEqualWithAccuracy(testCoords[index].longitude, point.longitude, accuracy: 0.001)
        }
    }

    func testDecodingToSequenceFailsForBadString() {
        let sut = testBadString
        XCTAssertThrowsError(try sut.asCoordinateSequence())
    }

    func testDecodingToArrayFailsForBadString() {
        let sut = testBadString
        XCTAssertThrowsError(try sut.asCoordinateArray())
    }

    func testEncodingCoordinates() {
        let sut = String(googlePolylineLocationCoordinateSequence: testCoords)
        XCTAssertEqual(sut, testString)
    }

    func testPerformance() {
        self.measureBlock {
            (0..<100).forEach { _ in
                let _ = try! testString.asCoordinateArray()
            }
        }
    }
}
