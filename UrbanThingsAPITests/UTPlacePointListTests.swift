//
//  UTPlacePointListTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 09/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import XCTest
@testable import UrbanThingsAPI

private let JSONFileName = "PlacePointListTests"

class UTPlacePointListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequiredInitialisation() throws {
        let _:UTPlacePointList = try self.initializationFromJSON(JSONFileName)
    }
    
    func testPerformance() throws {
        let json = self.loadJSON(JSONFileName)
        self.measureBlock {
            (0..<100).forEach { _ in
                let _ = try! UTPlacePointList(required: json)
            }
        }
    }
}
