//
//  NSLocale+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/08/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NSLocale {

    convenience init?(optional: AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }

    convenience init(required: AnyObject?) throws {
        guard let value = required as? String else {
            throw Error(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        self.init(localeIdentifier: value)
    }
}
