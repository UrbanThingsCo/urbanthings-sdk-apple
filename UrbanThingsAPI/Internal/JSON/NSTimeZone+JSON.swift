//
//  NSTimeZone+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

extension NSTimeZone {
    
    convenience init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
    
    convenience init(required:AnyObject?) throws {
        guard let value = required as? String else {
            throw Error(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        if let _ = NSTimeZone(name: value) {
            self.init(name: value)!
        } else if let _ = NSTimeZone(abbreviation: value) {
            self.init(abbreviation: value)!
        } else {
            throw Error(jsonParseError: "Unable to parse NSTimeZone from \(value)", file: #file, function: #function, line: #line)
        }
    }
}