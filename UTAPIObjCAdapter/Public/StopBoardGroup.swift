//
//  StopBoardGroup.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation


/// `StopBoardGroup` details grouping of `StopBoardRow` instances. Rows that have their `groupID` matching the
/// `groupID` of this structure should be grouped together.
@objc public protocol StopBoardGroup : StopBoardColor {
    /// An identifier for this group, unique to the parent StopBoard object.
    var groupID:String { get }
    /// A label describing the nature of this group, suitable for public display. The nature of groups is varied
    /// so examples might include: 'Arrivals', '326' or 'Platform 7'
    var label:String { get }
}