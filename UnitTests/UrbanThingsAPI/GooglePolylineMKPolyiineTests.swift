//
//  GooglePolylineMKPolyiineTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/07/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest

class GooglePolylineMKPolyiineTests: XCTestCase {

    @available(tvOS 9.2, *)
    func testEncodingMKMapPoints() {
        let sut = String(googlePolylineMapPointSequence: testCoords.map { MKMapPointForCoordinate($0) })
        XCTAssertEqual(sut, testString)
    }

    @available(tvOS 9.2, *)
    func testEncodingMKMultiPoint() {
        let multiPoint = MKPolyline(sequence: testCoords)
        let sut = String(googlePolylineMKMultiPoint: multiPoint)
        XCTAssertEqual(sut, testString)
    }

    @available(tvOS 9.2, *)
    func testDecodingToMKPolylineFailsForBadString() {
        let sut = testBadString
        XCTAssertThrowsError(try sut.asMKPolyline())
    }

}
