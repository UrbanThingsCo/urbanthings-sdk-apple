//
//  StopBoardColor.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.StopBoardColor
import typealias UrbanThingsAPI.UTColor

/// `StopBoardColor` details a color pair for background and text. Inherited by `StopBoard`, `StopBoardGroup` and `StopBoardMessage`.
@objc public protocol StopBoardColor {
    /// The color that represents this StopBoard - this may be used to add branding-specific colors to stops that relate to
    /// public transportation lines with a published brand colour. For example, London Underground lines have distinct branding
    /// colors per-line in the United Kingdom.
    var color:UTColor? { get }
    /// The color of text that can be legibly displayed against backgrounds of the color contained within the `color` field.
    var colorCompliment:UTColor? { get }
}

@objc public class UTStopBoardColor : NSObject, StopBoardColor {
    
    let adapted: UrbanThingsAPI.StopBoardColor
    
    public init(adapt: UrbanThingsAPI.StopBoardColor) {
        self.adapted = adapt
    }
    
    public var color:UTColor? { return self.adapted.color }
    public var colorCompliment:UTColor? { return self.adapted.colorCompliment }
}
