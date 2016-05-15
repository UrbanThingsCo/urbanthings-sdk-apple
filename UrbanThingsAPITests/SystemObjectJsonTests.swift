//
//  ComponentTests.swift
//  ComponentTests
//
//  Created by Mark Woollard on 01/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
@testable import UrbanThingsAPI

let TestString = "TestString"

struct TestPair<T> {
    let input:AnyObject?
    let expected:T?
    init(_ input:AnyObject?, _ expected:T?) {
        self.input = input
        self.expected = expected
    }
}

func testType<T : JSONInitialization where T : Equatable>(tests:[TestPair<T>]) {
    for test in tests {
        if let input = test.input {
            if let expected = test.expected {
                XCTAssertEqual(expected, try T(optional:input))
                XCTAssertEqual(expected, try T(required:input))
            } else {
                XCTAssertThrowsError(try T(optional:input))
                XCTAssertThrowsError(try T(required:input))
            }
        } else {
            XCTAssertNone(try! T(optional:test.input))
            XCTAssertThrowsError(try T(required:test.input))
        }
    }
}

class ComponentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Bool JSON initialization
    func testBool() {
        testType([
            TestPair(true, true),
            TestPair(false, false),
            TestPair(nil, nil),
            TestPair(32,true),
            TestPair(0, false),
            TestPair(TestString, nil)
            ])
    }

    // MARK: String JSON initialization
    func testString() {
        testType([
            TestPair(TestString, TestString),
            TestPair(nil, nil),
            TestPair(132, nil)
            ])
    }

    // MARK: UInt JSON initialization
    func testUInt() {
        testType([
            TestPair(UInt(123), UInt(123)),
            TestPair(nil, nil),
            TestPair(TestString, nil)
            ])
    }
    
}
