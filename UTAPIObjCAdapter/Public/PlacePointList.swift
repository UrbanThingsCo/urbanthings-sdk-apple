//
//  PlacePointList.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// PlacePointList contains results of a geographically bounded request for place points.
@objc public protocol PlacePointList {
    /// Array of place points that matched the search request
    var placePoints:[PlacePoint] { get }
    /// The source of the location lookup which should be displayed to end-users
    var sourceName:String { get }
    /// A URL to a graphic representing the source of the location lookup which should be displayed to end-users
    var sourceIconURL:NSURL { get }
}
