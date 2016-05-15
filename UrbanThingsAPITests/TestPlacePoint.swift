//
//  TestPlacePoint.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 05/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
@testable import UrbanThingsAPI

struct TestPlacePoint : PlacePoint {
    
    let name:String?
    let primaryCode:String
    let importSource:String? = nil
    let localityName:String? = nil
    let country:String? = nil
    let hasResourceStatus:Bool = false
    let location:Location
    let placePointType: PlacePointType = .Place

    init(primaryCode:String, name:String, location:Location) {
        self.primaryCode = primaryCode
        self.name = name
        self.location = location
    }
}