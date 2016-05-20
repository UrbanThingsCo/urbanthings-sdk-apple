//
//  XCTestCase+Extensions.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import XCTest
import CoreLocation
@testable import UTAPI

let mappingDict:[String:String] = [
    "timestamp" : "timeStamp",
    "calendarID" : "id",
    "pickupType" : "pickUpType",
    "dropoffType" : "dropOffType",
    "isRTI" : "isrti"
]

extension XCTestCase {
    
    class func getAPIInstanceAndJSON(jsonFile:String) throws -> (api:UrbanThingsAPIType, json:AnyObject?) {
        let requestHandler = try MockRequestHandler(jsonFile: jsonFile)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"a key"))
        return (api:UrbanThingsAPI(session: session, requestHandler: requestHandler), json:requestHandler.json)
    }

    func getAPIInstanceAndJSON(jsonFile:String) throws -> (api:UrbanThingsAPIType, json:AnyObject?) {
        return try XCTestCase.getAPIInstanceAndJSON(jsonFile)
    }
}

extension XCTestCase {
    
    func initializationFromJSON<T : JSONInitialization>(jsonFile: String) throws -> T {
        let _ = try self.optionalInitialisation(jsonFile) as T
        return try self.requiredInitialisation(jsonFile) as T
    }
    
    func loadJSON(file:String) -> AnyObject {
        let path = NSBundle(forClass: UTImportSourceTests.self).pathForResource(file, ofType: "json")
        let data = NSData(contentsOfFile: path!)
        return try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
    }
    
    private func requiredInitialisation<T : JSONInitialization>(jsonFile:String) throws -> T {
        XCTAssertThrowsError(try T(required:nil))
        return try commonInitialization(jsonFile)
    }
    
    private func optionalInitialisation<T : JSONInitialization>(jsonFile:String) throws -> T {
        XCTAssertNil(try T(optional:nil))
        return try commonInitialization(jsonFile) as T
    }

    private func commonInitialization<T : JSONInitialization>(jsonFile:String) throws -> T {
        let json = loadJSON(jsonFile)
        XCTAssertThrowsError(try T(required:"Test none JSON input"))
        let sut = try T(required: json)
        let result = try compare(sut, json: json)
        XCTAssertTrue(result)
        return sut
    }
    
    func compare<T:Equatable>(left:T?, _ right:T?, _ path:String) -> Bool {
        if left == right {
            return true
        }
        
        print("\(path) - \(left) != \(right)")
        return false
    }
    
    func compareValue(mirror:Mirror, subject:Any, json:AnyObject?, path:String) throws  -> Bool {
        guard let asJSONInit = subject as? JSONInitialization else {
            return try compareNonJSONInitialization(mirror, subject: subject, json: json, path:path)
        }

        let jsonValue = try asJSONInit.dynamicType.init(required: json)

        // Compare enums by their textual representation
        return compare("\(subject)", "\(jsonValue)", path)
    }

    func compareNonJSONInitialization(mirror:Mirror, subject:Any, json:AnyObject?, path:String) throws -> Bool {
        if let asDate = subject as? NSDate {
            let jsonValue = try (json as? String)?.requiredDate()
            if asDate == jsonValue {
                return true
            }
            let timestampValue = try NSDate.toDate(json)
            return compare(asDate, timestampValue, path)
        }
        
        if let asNSURL = subject as? NSURL {
            let jsonValue = try NSURL.fromJSON(required: json)
            return compare(asNSURL, jsonValue, path)
        }
        
        if let asNSTimeZone = subject as? NSTimeZone {
            let jsonValue = try NSTimeZone(required: json)
            return compare(asNSTimeZone, jsonValue, path)
        }
        
        if let asUTColor = subject as? UTColor {
            let jsonValue = try UTColor.fromJSON(required: json)
            return compare(asUTColor, jsonValue, path)
        }
        
        // Location is complicated since its built from two fields in the dictionary and the keys change
        // depending on the structure. Will have to add means of passing this info into the test methods.
        if let _ = subject as? Location {
            return true
        }
        
        // TODO: Implement proper validation
        if subject is Set<WeekDay> {
            return true
        }
        
        print("\(path) - unsupported type \(subject.dynamicType)")
        return false
    }
    
    func compareEnum(mirror:Mirror, subject:Any, json:AnyObject?, path:String) throws -> Bool {
        // Load enum, all the enums supported implement JSONInitialization so if we
        // have an enum that does not support JSONInitialization consider it a
        // failure
        guard let asJSONInit = subject as? JSONInitialization else {
            print("\(path) - unsupported enum \(subject.dynamicType)")
            return false
        }
        
        let jsonValue = try asJSONInit.dynamicType.init(required: json)
        
        // Compare enums by their textual representation
        return compare("\(subject)", "\(jsonValue)", path)
    }
    
    func compareOptional(mirror:Mirror, subject:Any?, json:AnyObject?, path:String) throws -> Bool {
        // If there are no childern then the optional is None and so JSON property should also
        // be none or something is wrong
        if mirror.children.count == 0 {
            if json != nil {
                print("\(path) - \(json) not nil")
            }
            return json == nil
        } else {
            let (_, some) = mirror.children.first!
            return try compare(some, json: json, path:path)
        }
    }
    
    func compareSequence(mirror:Mirror, subject:Any, json:AnyObject?, path:String) throws -> Bool {
        guard let jsonArray = json as? [AnyObject] else {
            print("\(path) - \(json) not [AnyObject]")
            return false
        }
        
        let count = mirror.children.reduce(0) { $0.0 + 1 }
        guard count == jsonArray.count else {
            print("\(path) - array counts differ")
            return false
        }
        
        for (index, element) in mirror.children.enumerate() {
            if try !compare(element.value, json: jsonArray[index], path: path + "[\(index)]") {
                return false
            }
        }
        
        return true
    }
    
    func compareLocation(location:Location, json:AnyObject?, path:String) -> Bool {
        guard let jsonDict = json as? [String:AnyObject] else {
            print("\(path) - \(json) not [String:AnyObject]")
            return false
        }
        // See if any of the possible codings work
        if let loc = try? CLLocationCoordinate2D(required:jsonDict, latitude:.Latitude, longitude:.Longitude) {
            if loc.latitude != location.latitude || loc.longitude != location.longitude {
                print("\(loc) != \(location)")
                return false
            }
            return true
        }
        // See if any of the possible codings work
        if let loc = try? CLLocationCoordinate2D(required:jsonDict, latitude:.TransitStopLatitude, longitude:.TransitStopLongitude) {
            if loc.latitude != location.latitude || loc.longitude != location.longitude {
                print("\(loc) != \(location)")
                return false
            }
            return true
        }
        
        print("\(path) - \(jsonDict) not location")
        return false
    }
    
    func compare(subject:Any, json:AnyObject?, path:String = "") throws -> Bool {
        let mirror = Mirror(reflecting: subject)
        guard let style = mirror.displayStyle else {
            return try compareValue(mirror, subject: subject, json: json, path:path)
        }
        
        switch style {
        case .Optional:
            return try compareOptional(mirror, subject: subject, json: json, path:path)
        case .Enum:
            return try compareEnum(mirror, subject: subject, json: json, path:path)
        case .Struct, .Class where mirror.children.count > 0:
            guard let json = json else {
                print("\(path) - JSON nil")
                return false
            }
            for child in mirror.children {
                if let label = child.label {
                    let jsonLabel = mappingDict[label] ?? label
                    // Location is a special case since its initialised from keys in the parent JSON
                    if let _ = child.value as? Location {
                        if !compareLocation(child.value as! Location, json: json, path:path) {
                            return false
                        }
                    } else if try !compare(child.value, json: json[jsonLabel], path:path + "." + jsonLabel) {
                        return false
                    }
                }
            }
            return try compareValue(mirror, subject: subject, json: json, path: path)
        case .Collection:
            return try compareSequence(mirror, subject: subject, json:json, path:path)
        default:
            break
        }
        
        return try compareValue(mirror, subject: subject, json: json, path:path)
    }
}

