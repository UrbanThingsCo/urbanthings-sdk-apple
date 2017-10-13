//
//  ContainerViewController.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import UIKit
import CoreLocation
import UTAPI

class ContainerViewController : UIViewController {
    
    var location:DemoLocation?
    var modes:[TransitMode] = [TransitMode.CycleHired, TransitMode.Car]
    
    @IBOutlet weak var attributionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.location = StopsModel.sharedInstance.demoLocations[0]
        self.refreshData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Ensure you have set a valid ApiKey in StopsModel.swift
        if !StopsModel.sharedInstance.hasValidApiKey() {
            let alert = UIAlertController(title: "No API Key", message: "To use the demo app you must insert your Api key into the appropriate place in file StopsModel.swift", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
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
        StopsModel.sharedInstance.setLocation(location: self.location!.location, types: self.modes)
    }
    
    @IBAction func chooseLocation(_ sender: UIBarButtonItem) {
        
        let action = UIAlertController(title:"Choose Location", message:nil, preferredStyle: .actionSheet)
        
        StopsModel.sharedInstance.demoLocations.forEach { demoLocation in
            action.addAction(UIAlertAction(title: demoLocation.title, style: .default, handler: { _ in
                self.location = demoLocation
                self.refreshData()
            }))
        }
        
        if action.popoverPresentationController == nil {
            action.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        }
        action.popoverPresentationController?.barButtonItem = sender
        self.present(action, animated: true, completion: nil)
    }
}

