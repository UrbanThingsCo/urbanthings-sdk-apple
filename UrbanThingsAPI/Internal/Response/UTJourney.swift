//
//  UTJourney.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTJourney : UTJourneyCore, Journey {
    
    let legs:[JourneyLeg]

    private class func legForJSON(json: [String: AnyObject]) throws -> JourneyLeg {
        if try String(optional: json[.Type]) == "TransitJourneyLeg" {
            return try UTTransitJourneyLeg(required: json)
        } else {
            return try UTJourneyLeg(required: json)
        }
    }

    class func parseLegs(json: AnyObject?) throws -> [JourneyLeg] {
        guard let jsonLegs = json as? [[String:AnyObject]] else {
            throw Error(expected: [[String:AnyObject]].self, not: json, file: #file, function: #function, line: #line)
        }
        return try jsonLegs.map { try UTJourney.legForJSON($0) }
    }
    
    override init(json: [String : AnyObject]) throws {
        self.legs = try parse(required: json, key: .Legs, type: UTJourney.self) { try UTJourney.parseLegs($0) }
        try super.init(json: json)
    }
}