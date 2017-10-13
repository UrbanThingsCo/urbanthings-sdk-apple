//
//  NSNotificationCenter+Extensions.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 09/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    private class AutoReleaseObserver {
        let observer:AnyObject
        init(_ observer:AnyObject) {
            self.observer = observer
        }
        deinit {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func addObserver(name:String, object:AnyObject? = nil, queue:OperationQueue? = nil, usingBlock block: @escaping (Notification) -> Void) -> AnyObject {
        return AutoReleaseObserver(
            self.addObserver(forName: NSNotification.Name(rawValue: name), object: object, queue: queue,  using: block)
        )
    }
}

