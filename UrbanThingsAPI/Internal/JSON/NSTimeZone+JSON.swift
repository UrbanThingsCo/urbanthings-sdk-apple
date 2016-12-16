//
//  NSTimeZone+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NSTimeZone {
    
    public convenience init?(optional:Any?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional as Any)
    }
    
    public convenience init(required:Any) throws {
        guard let value = required as? String else {
            throw UTAPIError(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        if let _ = NSTimeZone(name: value) {
            self.init(name: value)!
        } else if let _ = NSTimeZone(abbreviation: value) {
            self.init(abbreviation: value)!
        } else {
            throw UTAPIError(jsonParseError: "Unable to parse NSTimeZone from \(value)", file: #file, function: #function, line: #line)
        }
    }
}
