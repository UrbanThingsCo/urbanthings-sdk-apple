//
//  ContainerViewController.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import UIKit
import CoreLocation
import UrbanThingsAPI

class ContainerViewController : UIViewController {
    
    var location:DemoLocation?
    var modes:[TransitMode] = [TransitMode.CycleHired, TransitMode.Car]
    
    @IBOutlet weak var attributionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.location = StopsModel.sharedInstance.demoLocations[0]
        self.refreshData()
    }
    
    @IBAction func changeType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.modes = [TransitMode.CycleHired]
            break
        case 2:
            self.modes = [TransitMode.Car]
            break
        default:
            self.modes = [TransitMode.CycleHired, TransitMode.Car]
        }
        self.refreshData()
    }

    func refreshData() {
        self.navigationItem.rightBarButtonItem?.title = self.location?.title
        StopsModel.sharedInstance.setLocation(self.location!.location, types: self.modes)
    }
    
    @IBAction func chooseLocation(sender: UIBarButtonItem) {
        
        let action = UIAlertController(title:"Choose Location", message:nil, preferredStyle: .ActionSheet)
        
        StopsModel.sharedInstance.demoLocations.forEach { demoLocation in
            action.addAction(UIAlertAction(title: demoLocation.title, style: .Default, handler: { _ in
                self.location = demoLocation
                self.refreshData()
            }))
        }
        
        if action.popoverPresentationController == nil {
            action.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        }
        action.popoverPresentationController?.barButtonItem = sender
        self.presentViewController(action, animated: true, completion: nil)
    }
}

