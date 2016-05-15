//
//  Location.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

/// Geo-location specified in WGS84 coordinate projection
public protocol Location {
    /// Latitude in degrees
    var latitude:Double { get }
    /// Longitude in degrees
    var longitude:Double { get }
}

/// Provided to allow comparisions of location instances
func == (lhs: Location, rhs: Location) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
