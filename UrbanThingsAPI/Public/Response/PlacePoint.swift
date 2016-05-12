//
//  PlacePoint.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 25/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import CoreLocation

/// PlacePoint represents a place with a geo-location. 
///
/// Inherited by `TransitStop`
public protocol PlacePoint {
    
    /// Place point name in native locale, optional
    var name:String? { get }

    /// The import source (DataSet) that this object was originally sourced from, optional
    var importSource:String? { get }
    
    /// Globally unique primary code of the place point
    var primaryCode:String { get }
    
    /// Type of place point
    var placePointType:PlacePointType { get }

    /// Locality of the place point, optional
    var localityName:String? { get }

    /// Country of the place point in ISO 3166-1 alpha-2 format, optional
    var country:String? { get }
    
    /// If true the place point has resources that status requests can be made for
    var hasResourceStatus:Bool { get }

    /// Location of place point in lat/lng coordinates
    var location:Location { get }
}

