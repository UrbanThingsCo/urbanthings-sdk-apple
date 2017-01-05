//
//  NSLocale+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/08/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NSLocale {

    public convenience init?(optional: Any?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }

    public convenience init(required: Any?) throws {
        guard let value = required as? String else {
            throw UTAPIError(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        self.init(localeIdentifier: value)
    }
}
