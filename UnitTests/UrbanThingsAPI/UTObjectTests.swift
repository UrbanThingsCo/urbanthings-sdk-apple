//
//  UTObjectTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 04/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
@testable import UTAPI

func XCTAssertNone(value:Any?) {
    if let _ = value {
        XCTAssert(false, "Expected nil optional")
    }
}

class UTObjectTests: XCTestCase {
    
    class TestSubclass : UTObject {
        var overrideCallCount = 0
        var jsonReceived:AnyObject? = nil
        
        override init(json: [String : AnyObject]) throws {
            overrideCallCount += 1
            jsonReceived = json
            try super.init(json:json)
        }
    }

    class TestThrowSubclass : UTObject {
        override init(json: [String : AnyObject]) throws {
            throw Error.JSONParseError(message: "Test throw", debugInfo: "")
            try super.init(json:json)
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequiredInit() throws {
        let testData:[String:AnyObject] = ["A":"B"]
        let sut = try TestSubclass(required: testData)
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut.jsonReceived is [String:AnyObject])
        XCTAssertEqual("B", sut.jsonReceived!["A"])
        XCTAssertEqual(1, sut.overrideCallCount)
    }

    func testRequiredInitThrows() throws {
        XCTAssertThrowsError(try TestSubclass(required: nil))
        XCTAssertThrowsError(try TestSubclass(required: 123))
        XCTAssertThrowsError(try TestThrowSubclass(required:["A":1]))
    }
    
    func testOptionalInit() throws {
        let testData:[String:AnyObject] = ["A":"B"]
        let sut = try TestSubclass(optional: testData)
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut!.jsonReceived is [String:AnyObject])
        XCTAssertEqual("B", sut!.jsonReceived!["A"])
        XCTAssertEqual(1, sut!.overrideCallCount)
    }
    
    func testOptionalInitFails() throws {
        XCTAssertNone(try TestSubclass(optional: nil))
        XCTAssertThrowsError(try TestSubclass(optional: 123))
        XCTAssertThrowsError(try TestThrowSubclass(optional:["A":1]))
    }
    
    func testPerformance() {
        // This is an example of a performance test case.
        self.measureBlock {
            (0..<250).forEach { _ in
                let _ = try! UTObject(required: ["A":"B"])
            }
        }
    }
    
}
