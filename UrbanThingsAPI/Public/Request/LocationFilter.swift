//
//  LocationFilter.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines a location filter for request parameters
public enum LocationFilter {
    /// A geo location point with optional country code
    case Point(CLLocationCoordinate2D, String?)
    /// A country code
    case Country(String)
}


extension LocationFilter : CustomStringConvertible {
    
    public var description:String {
        switch self {
        case Point(let location, let country):
            if let country = country {
                return "LocationFilter.Point(\(location), \(country)"
            } else {
                return "LocationFilter.Point(\(location))"
            }
        case Country(let country):
            return "LocationFilter.Country(\(country))"
        }
    }
    
}