//
//  String+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 01/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Extend `String` to support JSONInitialization protocol for JSON parsing.
extension String : JSONInitialization {
    
    init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
    
    init(required:AnyObject?) throws {
        guard let value = required as? String else {
            throw Error(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        self = value
    }

    var hexValue:UInt32? {
        
        let trimmed = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if trimmed.characters.first == "#" {
            return trimmed.substringFromIndex(trimmed.startIndex.successor()).hexValue
        } else if trimmed.hasPrefix("0x") || trimmed.hasPrefix("0X") {
            return trimmed.substringFromIndex(trimmed.startIndex.advancedBy(2)).hexValue
        }
        
        return UInt32(trimmed, radix:16)
    }
}


