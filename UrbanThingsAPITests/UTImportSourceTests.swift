//
//  UTImportSourceTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
@testable import UrbanThingsAPI

class UTImportSourceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialisation() throws {
        let _:UTImportSource = try self.initializationFromJSON("ImportSourceTests")
    }

    func testPerformance() throws {
        let json = self.loadJSON("ImportSourceTests")
        self.measureBlock {
            (0..<100).forEach { _ in
                let _ = try! UTImportSource(required: json)
            }
        }
    }
    
}
