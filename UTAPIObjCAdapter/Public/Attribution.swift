//
//  Attribution.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

@objc public protocol Attribution : NSObjectProtocol {
    /// An attribution label text for the data - clients MUST display either this label or the string contained at AttributionLabel to conform with the Terms and Conditions of using the API.
    var attributionLabel:String? { get }
    /// An attribution graphic for the data - clients MUST display either this label or the string contained at AttributionLabel to conform with the Terms and Conditions of using the API.
    var attributionImageURL:URL? { get }
    /// Optional guidance explaining how the AttributionText and AttributionImageURL should be displayed.
    var attributionNotes:String? { get }
}

@objc public class UTAttribution : NSObject, Attribution {
    
    let adapted:UTAPI.Attribution
    
    public init(adapt:UTAPI.Attribution) {
        self.adapted = adapt
    }
    
    public var attributionLabel:String? { return self.adapted.attributionLabel }
    public var attributionImageURL:URL? {return self.adapted.attributionImageURL }
    public var attributionNotes:String? { return self.adapted.attributionNotes }
}
