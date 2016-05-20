//
//  ImportSourceAdapterTests.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 18/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import UTAPIObjCAdapter
@testable import UTAPI

@objc class StaticAdapterTestsSwift : NSObject {

    @objc class func getImportSources() -> [UTAPIObjCAdapter.ImportSource]? {
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("ImportSources")
        var objc:[UTAPIObjCAdapter.ImportSource]?
        let _ = sut.sendRequest(UTImportSourcesRequest()) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTImportSource(adapt:$0) }
            }
        }
        return objc
    }
    
    @objc class func getTransitStops()  -> [UTAPIObjCAdapter.TransitStop]?  {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("TransitStops")
        var objc:[UTAPIObjCAdapter.TransitStop]?
        let _ = sut.sendRequest(UTTransitStopsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitStop(adapt:$0) }
            }
        }
        return objc
    }

    @objc class func getPlacePoints() -> UTAPIObjCAdapter.PlacePointList? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("PlacePoints")
        var objc:UTAPIObjCAdapter.PlacePointList?
        let _ = sut.sendRequest(UTPlacePointsRequest(center: CLLocationCoordinate2D(latitude:0, longitude:0), radius: 100)) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTPlacePointList(adapt:data)
            }
        }
        return objc
    }
    
    @objc class func getPlacesList() -> UTAPIObjCAdapter.PlacePointList? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("PlacesList")
        var objc:UTAPIObjCAdapter.PlacePointList?
        let _ = sut.sendRequest(UTPlacesListRequest(name:"a", country:"gb")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTPlacePointList(adapt:data)
            }
        }
        return objc
    }
    
    @objc class func getTransitRoutesByLineName() -> [UTAPIObjCAdapter.TransitDetailedRouteInfo]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("TransitRoutesByLineName")
        var objc:[UTAPIObjCAdapter.TransitDetailedRouteInfo]?
        let _ = sut.sendRequest(UTTransitRoutesByLineNameRequest(lineName:"ABC", agencyID:"123")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitDetailedRouteInfo(adapt:$0)! }
            }
        }
        
        return objc
    }
    
    @objc class func getTransitRoutesByImportSource() -> [UTAPIObjCAdapter.TransitDetailedRouteInfo]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("TransitRoutesByImportSource")
        var objc:[UTAPIObjCAdapter.TransitDetailedRouteInfo]?
        let _ = sut.sendRequest(UTTransitRoutesByImportSourceRequest(importSource:"TFL")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitDetailedRouteInfo(adapt:$0)! }
            }
        }
        return objc
    }
    
    @objc static func getTransitRoutesCallingAtStops() -> [UTAPIObjCAdapter.TransitDetailedRouteInfo]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("CallingAtStops")
        var objc:[UTAPIObjCAdapter.TransitDetailedRouteInfo]?
        let _ = sut.sendRequest(UTTransitRoutesByStopRequest(stopID: "abc")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitDetailedRouteInfo(adapt:$0)! }
            }
        }
        return objc
    }
    
    @objc class func getTransitAgencies() -> [UTAPIObjCAdapter.TransitAgency]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("TransitAgencies")
        var objc:[UTAPIObjCAdapter.TransitAgency]?
        let _ = sut.sendRequest(UTTransitAgenciesRequest(importSource:"TFL")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitAgency(adapt:$0) }
            }
        }
        return objc
    }
    
    @objc static func getTransitAgency() -> UTAPIObjCAdapter.TransitAgency? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("TransitAgency")
        var objc:UTAPIObjCAdapter.TransitAgency?
        let _ = sut.sendRequest(UTTransitAgencyRequest(agencyID:"TFL")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = UTAPIObjCAdapter.UTTransitAgency(adapt:data)
            }
        }
        return objc
    }

    @objc static func getTripGroups() -> [UTAPIObjCAdapter.TransitTripCalendarGroup]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("TripGroups")
        var objc:[UTAPIObjCAdapter.TransitTripCalendarGroup]?
        let _ = sut.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitTripCalendarGroup(adapt:$0) }
            }
        }
        return objc
    }

    @objc static func getTrips() -> [UTAPIObjCAdapter.TransitTrip]? {
        
        let (sut, _) = try! XCTestCase.getAPIInstanceAndJSON("Trips")
        var objc:[UTAPIObjCAdapter.TransitTrip]?
        let _ = sut.sendRequest(UTTransitTripsRequest(routeID: "abc")) { data, error in
            XCTAssertNil(error)
            if let data = data {
                objc = data.map { UTAPIObjCAdapter.UTTransitTrip(adapt:$0) }
            }
        }
        
        return objc
    }
}
