//
//  UTColor+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 01/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

#if os(OSX)
    import AppKit
    public typealias UTColor = NSColor
#else
    import UIKit
    public typealias UTColor = UIColor
#endif

extension UTColor {

    public class func fromJSON(required: Any?) throws -> UTColor {
        guard let string = required as? String else {
            throw UTAPIError(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = string.hexValue else {
            throw UTAPIError(jsonParseError:"Invalid hex string \(string)", file:#file, function:#function, line:#line)
        }

        #if os(OSX)
            return UTColor(deviceRed:CGFloat((value & 0xff0000) >> 16)/255.0,
                      green:CGFloat((value & 0xff00) >> 8)/255.0,
                      blue:CGFloat(value & 0xff)/255.0,
                      alpha:1.0)
        #else
            return UTColor(red:CGFloat((value & 0xff0000) >> 16)/255.0,
                      green:CGFloat((value & 0xff00) >> 8)/255.0,
                      blue:CGFloat(value & 0xff)/255.0,
                      alpha:1.0)
        #endif
    }

    public class func fromJSON(optional: Any?) throws -> UTColor? {
        guard let required = optional else {
            return nil
        }
        return try UTColor.fromJSON(required:required)
    }
}
