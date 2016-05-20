//
//  DirectionsAdapterRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 20/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import UTAPIObjCAdapter
@testable import UTAPI

@objc class DirectionsAdapterTestsSwift : NSObject {
    
    @objc static func getDirections() -> UTAPIObjCAdapter.DirectionsResponse? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("Directions")
        var objc:UTAPIObjCAdapter.DirectionsResponse?
        let _ = sut.sendRequest(directionsRequest) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTDirectionsResponse(adapt: data)
            }
        }
        return objc
    }
    
}