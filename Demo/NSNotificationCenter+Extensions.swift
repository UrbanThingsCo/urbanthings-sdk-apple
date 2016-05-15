//
//  NSNotificationCenter+Extensions.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 09/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
    
    private class AutoReleaseObserver {
        let observer:AnyObject
        init(_ observer:AnyObject) {
            self.observer = observer
        }
        deinit {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
    }
    
    func addObserver(name:String, object:AnyObject? = nil, queue:NSOperationQueue? = nil, usingBlock block: (NSNotification) -> Void) -> AnyObject {
        return AutoReleaseObserver(
            self.addObserverForName(name, object: object, queue: queue,  usingBlock: block)
        )
    }
}

