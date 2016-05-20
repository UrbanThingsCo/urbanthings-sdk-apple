//
//  PlacePoint.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation
import UTAPI

/// PlacePoint represents a place with a geo-location.
///
/// Inherited by `TransitStop`
@objc public protocol PlacePoint : NSObjectProtocol {
    
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
    var location:CLLocationCoordinate2D { get }
}

@objc public class UTPlacePoint : NSObject, PlacePoint {
    
    let adapted:UTAPI.PlacePoint
    
    public init(adapt:UTAPI.PlacePoint) {
        self.adapted = adapt
        self.location = CLLocationCoordinate2D(latitude: adapt.location.latitude, longitude: adapt.location.longitude)
    }
    
    public var name:String? { return self.adapted.name }
    public var importSource:String? { return self.adapted.importSource }
    public var primaryCode:String { return self.adapted.primaryCode }
    public var placePointType:PlacePointType { return self.adapted.placePointType }
    public var localityName:String? { return self.adapted.localityName }
    public var country:String? { return self.adapted.country }
    public var hasResourceStatus:Bool { return self.adapted.hasResourceStatus }
    public let location:CLLocationCoordinate2D
}
