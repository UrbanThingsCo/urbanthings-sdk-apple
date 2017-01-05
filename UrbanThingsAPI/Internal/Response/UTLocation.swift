//
//  Location.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D : Location {}

public typealias UTLocation = CLLocationCoordinate2D

extension CLLocationCoordinate2D: JSONInitialization {

    public init?(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude, let longitude = longitude else {
            return nil
        }

        self.latitude = latitude
        self.longitude = longitude
    }

    public init(required: Any?, latitude: JSONKey, longitude: JSONKey) throws {
        guard let json = required as? [String:AnyObject] else {
            throw UTAPIError(expected: [String:AnyObject].self, not: required, file:#file, function:#function, line:#line)
        }
        guard let lat = json[latitude] as? Double, let lng = json[longitude] as? Double else {
            throw UTAPIError(jsonParseError:"Missing coordinate \(latitude) and/or \(longitude) in \(json)", file:#file, function:#function, line:#line)
        }

        self.latitude = lat
        self.longitude = lng
    }

    public init?(optional: Any?, latitude: JSONKey, longitude: JSONKey) throws {
        guard let json = optional as? [String:AnyObject] else {
            return nil
        }

        let lat = json[JSONKey.Latitude] as? Double
        let lng = json[JSONKey.Longitude] as? Double

        guard lat != nil && lng != nil else {
            if lat != nil || lng != nil {
                throw UTAPIError(jsonParseError:"Missing coordinate \(latitude) and/or \(longitude) in \(json)", file:#file, function:#function, line:#line)
            }
            return nil
        }

        self.latitude = lat!
        self.longitude = lng!
    }

    public init(required: Any?) throws {
        try self.init(required: required, latitude: .Latitude, longitude: .Longitude)
    }

    public init?(optional: Any?) throws {
        guard let json = optional as? [String:Any] else {
            return nil
        }
        try self.init(required: json)
    }

    public init(required: [String: Any], key: JSONKey) throws {
        try self.init(required: required[key])
    }
}
