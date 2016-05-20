//
//  StopBoardGroup.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `StopBoardGroup` details grouping of `StopBoardRow` instances. Rows that have their `groupID` matching the
/// `groupID` of this structure should be grouped together.
@objc public protocol StopBoardGroup : StopBoardColor {
    /// An identifier for this group, unique to the parent StopBoard object.
    var groupID:String { get }
    /// A label describing the nature of this group, suitable for public display. The nature of groups is varied
    /// so examples might include: 'Arrivals', '326' or 'Platform 7'
    var label:String { get }
}

@objc public class UTStopBoardGroup : UTStopBoardColor, StopBoardGroup {
    
    var stopBoardGroup: UTAPI.StopBoardGroup { return self.adapted as! UTAPI.StopBoardGroup }
    
    public init(adapt: UTAPI.StopBoardGroup) {
        super.init(adapt: adapt)
    }
    
    public var groupID:String { return self.stopBoardGroup.groupID }
    public var label:String { return self.stopBoardGroup.label }
}
