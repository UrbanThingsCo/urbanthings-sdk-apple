//
//  UTObject.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

open class UTObject: JSONInitialization {
    convenience required public init?(optional: Any?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }

    convenience required public init(required: Any?) throws {
        guard let json = required as? [String:Any] else {
            throw UTAPIError(expected: [String:Any].self, not: required, file:#file, function:#function, line:#line)
        }
        try self.init(json:json)
    }

    public init(json: [String:Any]) throws {
    }

    class var className: String {
        return "\(self)"
    }
}

public func parse<T: JSONInitialization>(required json: [String:Any], type: Any.Type, property: String) throws -> T {
    do {
        return try T(required:json)
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

public func parse<T: JSONInitialization>(optional json: [String:Any], type: Any.Type, property: String) throws -> T? {
    do {
        return try T(optional:json)
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

public func parse<T: JSONInitialization>(required json: [String:Any], key: JSONKey, type: Any.Type) throws -> T {
    do {
        return try T(required:json[key])
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

public func parse<T: JSONInitialization>(optional json: [String:Any], key: JSONKey, type: Any.Type) throws -> T? {
    do {
        return try T(optional:json[key])
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

public func parse<T>(required json: [String:Any], key: JSONKey, type: Any.Type, parser: (Any?) throws -> T) throws -> T {
    do {
        return try parser(json[key])
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

public func parse<T>(optional json: [String:Any], key: JSONKey, type: Any.Type, parser: (Any?) throws -> T?) throws -> T? {
    do {
        return try parser(json[key])
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(key) from \(json)", innerError: error)
    }
}

public func parse<T>(required json: [String:Any], type: Any.Type, property: String, parser: (Any?) throws -> T) throws -> T {
    do {
        return try parser(json)
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}

public func parse<T>(optional json: [String:Any], type: Any.Type, property: String, parser: (Any?) throws -> T?) throws -> T? {
    do {
        return try parser(json)
    } catch {
        throw UTAPIError.Rethrown(message: "Parsing \(type).\(property) from \(json)", innerError: error)
    }
}
