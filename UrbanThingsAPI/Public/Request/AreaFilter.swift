//
//  AreaFilter.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines an area filter for request parameters. The filter describes either a circular region
/// around an central point or a rectangle defined by top left and bottom right coordinates
public enum AreaFilter {
    /// Area is circular, based on geo-coordinate and radius (of up to 10000m)
    case Circle(Location, UInt)
    /// Area is rectanglular defined by the rectangle contained by two geo-coordinates
    case Rectangle(Location, Location)
}

extension AreaFilter : CustomStringConvertible {
    
    public var description:String {
        switch self {
        case .Circle(let location, let radius):
            return "AreaFilter.Circle(lat=\(location.latitude),lng=\(location.longitude),r=\(radius)m)"
        case .Rectangle(let topLeft, let bottomRight):
            return "AreaFilter.Rectangle(lat=\(topLeft.latitude),lng=\(topLeft.longitude)-lat=\(bottomRight.latitude),lng=\(bottomRight.longitude))"
        }
    }
}