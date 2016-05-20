//
//  RealtimeAdapterTests.swift
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

@objc class RealtimeAdapterTestsSwift : NSObject {
    
    @objc class func getRTIReport() -> UTAPIObjCAdapter.TransitStopRTIResponse? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("RealtimeReport")
        var objc:UTAPIObjCAdapter.TransitStopRTIResponse?
        let _ = sut.sendRequest(UTRealtimeReportRequest(stopID:"123")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTTransitStopRTIResponse(adapt: data)
            }
        }
        
        return objc
    }
    
    @objc class func getRTIStopboard() -> UTAPIObjCAdapter.StopBoardResponse? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("RealtimeStopBoard")
        var objc:UTAPIObjCAdapter.StopBoardResponse?
        let _ = sut.sendRequest(UTRealtimeStopboardRequest(stopID:"123")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTStopBoardResponse(adapt: data)
            }
        }
        return objc
    }
    
    @objc class func getRTIStatus() -> UTAPIObjCAdapter.ResourceStatus? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("RealtimeStatus")
        var objc:UTAPIObjCAdapter.ResourceStatus?
        let _ = sut.sendRequest(UTRealtimeResourceStatusRequest(stopID:"123")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTResourceStatus(adapt: data)
            }
        }
        return objc
    }
    
    @objc class func getRTIStatuses() -> [UTAPIObjCAdapter.ResourceStatus]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("RealtimeStatuses")
        var objc:[UTAPIObjCAdapter.ResourceStatus]?
        let _ = sut.sendRequest(UTRealtimeResourcesStatusRequest(stopIDs:["123"])) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTResourceStatus(adapt: $0) }
            }
        }
        return objc
    }
}
