//
//  APIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

///
struct APIResponse<T> : APIResponseType {
    typealias DataType = T
    
    let success:Bool
    let localizedErrorMessage:String?
    let data:T?
    
    init(json:AnyObject, parser:(json:AnyObject?, logger:Logger) throws -> T, logger:Logger) throws {
        guard let dict = json as? [String:AnyObject] else {
            throw Error(expected: [String:AnyObject].self, not: json, file:#file, function:#function, line:#line)
        }
        
        guard let ok = dict[.Success] as? Bool else {
            throw Error(jsonParseError:"Expected Bool 'success' value in \(dict)", file:#file, function:#function, line:#line)
        }
        
        let jsonData = dict[.Data]
        if ok && jsonData == nil {
            throw Error(jsonParseError:"Expected 'data' value in \(dict)", file:#file, function:#function, line:#line)
        }
        
        self.data = try parser(json: jsonData, logger: logger) as T
        self.success = ok
        self.localizedErrorMessage = dict[.LocalizedErrorMessage] as? String
    }
}
