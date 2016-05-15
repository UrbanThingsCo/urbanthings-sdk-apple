//
//  ImportSource.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation


@objc public protocol ImportSource : Attribution {
    /// The unique identifier representing the source of the data. Used as a foreign key in some objects, e.g. TransitAgency.
    var importSourceID:String { get }
    /// The name of the dataset
    var name:String { get }
    /// Optional comments to clarify the source of the data or explain its origin.
    var comments:String? { get }
    /// Optional URL to a web page describing the source of the data.
    var sourceInfoURL:NSURL? { get }
    /// Optional URL linking to the external data itself.
    var sourceDataURL:NSURL? { get }
}