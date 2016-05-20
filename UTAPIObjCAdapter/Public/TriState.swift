//
//  TriState.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

@objc public enum TriState : Int {
    case False = 0
    case True = 1
    case Unknown = 2
    
    init(_ optional:Bool?) {
        if let optional = optional {
            self = optional ? .True : .False
        }
        self = .Unknown
    }
}
