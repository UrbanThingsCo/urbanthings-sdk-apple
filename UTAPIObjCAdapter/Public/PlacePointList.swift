//
//  PlacePointList.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.PlacePointList
import protocol UrbanThingsAPI.PlacePoint

/// PlacePointList contains results of a geographically bounded request for place points.
@objc public protocol PlacePointList {
    /// Array of place points that matched the search request
    var placePoints:[PlacePoint] { get }
    /// The source of the location lookup which should be displayed to end-users
    var sourceName:String { get }
    /// A URL to a graphic representing the source of the location lookup which should be displayed to end-users
    var sourceIconURL:NSURL { get }
}

@objc public class UTPlacePointList : NSObject, PlacePointList {
    
    let adapted: UrbanThingsAPI.PlacePointList
    
    public init(adapt: UrbanThingsAPI.PlacePointList) {
        self.adapted = adapt
        self.placePoints = adapt.placePoints.map { UTPlacePoint(adapt: $0) }
    }
    
    public let placePoints:[PlacePoint]
    public var sourceName:String { return self.adapted.sourceName }
    public var sourceIconURL:NSURL { return self.adapted.sourceIconURL }
}
