//
//  UTTransitJourneyLeg.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 09/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitJourneyLeg : UTJourneyLeg, TransitJourneyLeg {
    
    /// An object containing details of the public transportation Route to which this leg's Trip (see LinkedTransitTripInfo) belongs, if known. For example the '326 bus service'.
    let linkedTransitRouteInfo: TransitRouteInfo?
    /// An object that contains details of the public transportation Trip that this leg forms part of, if known.
    let linkedTransitTripInfo: TransitTripInfo?
    /// A list of stops that will be called at en-route, if known.
    let scheduledStopCalls: [TransitScheduledCall]?

    override init(json: [String : Any]) throws {
        self.linkedTransitRouteInfo = try parse(optional: json, key: .LinkedTransitRouteInfo, type: UTTransitJourneyLeg.self) as UTTransitRouteInfo?
        self.linkedTransitTripInfo = try parse(optional: json, key: .LinkedTransitTripInfo, type: UTTransitJourneyLeg.self) as UTTransitTripInfo?
        self.scheduledStopCalls = try parse(optional:json, key: .ScheduledStopCalls, type:UTTransitJourneyLeg.self) { try [UTTransitScheduledCall](optional:$0) }?.map { $0 as TransitScheduledCall }
        try super.init(json: json)
    }
}
