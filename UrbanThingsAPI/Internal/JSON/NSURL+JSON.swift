//
//  NSURL+Extensions.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension URL {
    
    public static func fromJSON(required:Any?) throws -> URL {
        guard let urlString = required as? String else {
            throw UTAPIError(jsonParseError:"Expected String, not \(String(describing: required))", file:#file, function:#function, line:#line)
        }
        guard let url = URL(string: urlString) else {
            throw UTAPIError(jsonParseError:"Invalid url string \(urlString)", file:#file, function:#function, line:#line)
        }
        return url
    }
    
    public static func fromJSON(optional:Any?) throws -> URL? {
        guard optional != nil else {
            return nil
        }
        return try self.fromJSON(required: optional)
    }
}
