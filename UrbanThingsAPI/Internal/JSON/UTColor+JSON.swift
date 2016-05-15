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
    
    class func fromJSON(required required:AnyObject?) throws -> UTColor {
        guard let string = required as? String else {
            throw Error(expected:String.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = string.hexValue else {
            throw Error(jsonParseError:"Invalid hex string \(string)", file:#file, function:#function, line:#line)
        }
        return UTColor(rgb:value)
    }
    
    class func fromJSON(optional optional:AnyObject?) throws -> UTColor? {
        guard let required = optional else {
            return nil
        }
        return try UTColor.fromJSON(required:required)
    }
    
    convenience init(rgb:UInt32) {
        #if os(OSX)
            self.init(deviceRed:CGFloat((rgb & 0xff0000) >> 16)/255.0,
                      green:CGFloat((rgb & 0xff00) >> 8)/255.0,
                      blue:CGFloat(rgb & 0xff)/255.0,
                      alpha:1.0)
        #else
            self.init(red:CGFloat((rgb & 0xff0000) >> 16)/255.0,
                      green:CGFloat((rgb & 0xff00) >> 8)/255.0,
                      blue:CGFloat(rgb & 0xff)/255.0,
                      alpha:1.0)
        #endif
    }
}