//
//  UTJourney.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTJourney : UTJourneyCore, Journey {
    
    let legs:[JourneyLeg]

    private class func legForJSON(json: [String: Any]) throws -> JourneyLeg {
        if try String(optional: json[.Type]) == "TransitJourneyLeg" {
            return try UTTransitJourneyLeg(required: json)
        } else {
            return try UTJourneyLeg(required: json)
        }
    }

    class func parseLegs(json: Any?) throws -> [JourneyLeg] {
        guard let jsonLegs = json as? [[String:Any]] else {
            throw UTAPIError(expected: [[String:Any]].self, not: json, file: #file, function: #function, line: #line)
        }
        return try jsonLegs.map { try UTJourney.legForJSON(json: $0) }
    }
    
    override init(json: [String : Any]) throws {
        self.legs = try parse(required: json, key: .Legs, type: UTJourney.self) { try UTJourney.parseLegs(json: $0) }
        try super.init(json: json)
    }
}
