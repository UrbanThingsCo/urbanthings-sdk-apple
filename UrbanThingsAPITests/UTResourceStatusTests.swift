//
//  UTResourceStatusTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import XCTest
@testable import UrbanThingsAPI

private let JSONFileName = "ResourceStatusTests"

class UTResourceStatusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialisation() throws {
        let _:UTResourceStatus = try self.initializationFromJSON(JSONFileName)
    }

    func testPerformance() throws {
        let json = self.loadJSON(JSONFileName)
        self.measureBlock {
            (0..<100).forEach { _ in
                let _ = try! UTResourceStatus(required: json)
            }
        }
    }

}
