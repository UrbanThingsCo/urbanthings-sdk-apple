//
//  TransitRouteInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import UrbanThingsAPI
import CoreLocation

@objc public protocol TransitRouteInfo {
    /// A unique code that represents the agency operating this particular route, optional.
    var agencyCode:String? { get }
    /// A unique code that represents this route. Note that IDs in some regions may change periodically and thus should not be stored on the client.
    var routeID:String? { get }
    /// The public-facing line name, e.g. '324' for a 324 bus.
    var lineName:String? { get }
    /// The display color of the route, optional.
    var lineColor:UTColor? { get }
    /// The display color for text to be overlaid onto area with background of lineColor, optional.
    var lineTextColor:UTColor? { get }
    /// The name of the operator that runs this route, optional.
    var operatorName:String? { get }
    /// A unique identifier representing the operator that runs this route, optional.
    var operatorID:String? { get }
    /// The region, within the agency, of this operator, note not used by most agencies but used in the UK, optional.
    var operatorRegion:String? { get }
    /// The mode of transport that runs along this route.
    var routeType:TransitMode { get }
    /// Location of the geographical centre point of this route, (based on analysing the route's longest trips in each direction). This may be used to aid in sorting routes by proximity. Will be CLLocationCoordinate2DInvalid if no data available.
    var centerPoint:CLLocationCoordinate2D { get }
}