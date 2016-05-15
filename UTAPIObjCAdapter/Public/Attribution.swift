//
//  Attribution.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation


@objc public protocol Attribution {
    /// An attribution label text for the data - clients MUST display either this label or the string contained at AttributionLabel to conform with the Terms and Conditions of using the API.
    var attributionLabel:String? { get }
    /// An attribution graphic for the data - clients MUST display either this label or the string contained at AttributionLabel to conform with the Terms and Conditions of using the API.
    var attributionImageURL:NSURL? { get }
    /// Optional guidance explaining how the AttributionText and AttributionImageURL should be displayed.
    var attributionNotes:String? { get }
}
