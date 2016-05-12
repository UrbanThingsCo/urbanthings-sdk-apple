//
//  TransitDetailedRouteInfoType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Contains detailed information for a transit route.
///
/// Extends `TransitRouteInfo`
public protocol TransitDetailedRouteInfo : TransitRouteInfo {
    /// Detailed description of the route, optional.
    var routeDescription:String? { get }
}