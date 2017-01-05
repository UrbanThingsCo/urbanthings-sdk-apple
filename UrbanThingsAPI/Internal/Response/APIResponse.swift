//
//  APIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

///
struct APIResponse<T> : APIResponseType {
    typealias DataType = T

    let data: T?

    init(json: AnyObject, parser:(_ json: AnyObject?, _ logger: Logger) throws -> T, logger: Logger) throws {
        self.data = try parser(json, logger) as T
    }
}
