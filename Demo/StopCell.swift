//
//  StopCell.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import UIKit
import UrbanThingsAPI

class StopCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var request:UrbanThingsAPIRequest?
    
    func bind(stop:TransitStop) {
        self.nameLabel?.text = stop.name!
        self.typeLabel?.text = "Checking..."
        self.request = StopsModel.sharedInstance.getStopResources(stop) { status in
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.typeLabel.text = status ?? "Unavailable"
                self.request = nil
            }
        }
    }
    
    func unbind() {
        request?.cancel()
        request = nil
    }
}