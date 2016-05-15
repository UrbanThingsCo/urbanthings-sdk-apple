//
//  UTObject.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTObject : JSONInitialization {
    convenience required init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
    
    convenience required init(required:AnyObject?) throws {
        guard let json = required as? [String:AnyObject] else {
            throw Error(expected: [String:AnyObject].self, not: required, file:#file, function:#function, line:#line)
        }
        try self.init(json:json)
    }
    
    init(json:[String:AnyObject]) throws {
    }
    
    class var className:String {
        return "\(self)"
    }
}

func parse<T : JSONInitialization>(required json:[String:AnyObject], type:Any.Type, property:String) throws -> T {
    do {
        return try T(required:json)
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

func parse<T : JSONInitialization>(optional json:[String:AnyObject], type:Any.Type, property:String) throws -> T? {
    do {
        return try T(optional:json)
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

func parse<T : JSONInitialization>(required json:[String:AnyObject], key:JSONKey, type:Any.Type) throws -> T {
    do {
        return try T(required:json[key])
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

func parse<T : JSONInitialization>(optional json:[String:AnyObject], key:JSONKey, type:Any.Type) throws -> T? {
    do {
        return try T(optional:json[key])
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

func parse<T>(required json:[String:AnyObject], key:JSONKey, type:Any.Type, parser:(AnyObject?) throws -> T) throws -> T {
    do {
        return try parser(json[key])
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

func parse<T>(optional json:[String:AnyObject], key:JSONKey, type:Any.Type, parser:(AnyObject?) throws -> T?) throws -> T? {
    do {
        return try parser(json[key])
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

func parse<T>(required json:[String:AnyObject], type:Any.Type, property:String, parser:(AnyObject?) throws -> T) throws -> T {
    do {
        return try parser(json)
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

func parse<T>(optional json:[String:AnyObject], type:Any.Type, property:String, parser:(AnyObject?) throws -> T?) throws -> T? {
    do {
        return try parser(json)
    } catch {
        throw Error.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

