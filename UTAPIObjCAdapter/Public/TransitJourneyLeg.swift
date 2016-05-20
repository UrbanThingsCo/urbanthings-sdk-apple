//
//  TransitJourneyLeg.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `TransitJourneyLeg` protocol extends `JourneyLeg` to add details specific to a journey leg taken by transit service such as bus or train.
@objc public protocol TransitJourneyLeg : JourneyLeg {
    
    /// An object containing details of the public transportation Route to which this leg's Trip (see LinkedTransitTripInfo) belongs, if known. For example the '326 bus service'.
    var linkedTransitRouteInfo: TransitRouteInfo? { get }
    /// An object that contains details of the public transportation Trip that this leg forms part of, if known.
    var linkedTransitTripInfo: TransitTripInfo? { get }
    /// A list of stops that will be called at en-route, if known.
    var scheduledStopCalls: [TransitScheduledCall]? { get }
    
}

@objc public class UTTransitJourneyLeg : UTJourneyLeg, TransitJourneyLeg {
    
    var transitJourneyLeg:UTAPI.TransitJourneyLeg { return self.adapted as! UTAPI.TransitJourneyLeg }
    
    public init(adapt: UTAPI.TransitJourneyLeg) {
        self.linkedTransitRouteInfo = UTTransitRouteInfo(adapt: adapt.linkedTransitRouteInfo)
        self.linkedTransitTripInfo = UTTransitTripInfo(adapt: adapt.linkedTransitTripInfo)
        self.scheduledStopCalls = adapt.scheduledStopCalls?.map { UTTransitScheduledCall(adapt: $0) }
        super.init(adapt: adapt)
    }
    
    public let linkedTransitRouteInfo: TransitRouteInfo?
    public let linkedTransitTripInfo: TransitTripInfo?
    public let scheduledStopCalls: [TransitScheduledCall]?
}
