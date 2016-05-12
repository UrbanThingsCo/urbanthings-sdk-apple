//
//  StopsListViewController.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import UIKit
import UrbanThingsAPI

class StopsListViewController : UITableViewController {
 
    var updateObserver:AnyObject?
    var selectionObserver:AnyObject?
    var data:[TransitStop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateObserver = NSNotificationCenter.defaultCenter().addObserver(StopDataUpdated, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
            self.data = StopsModel.sharedInstance.data
            self.tableView.reloadData()
        }
        
        self.selectionObserver = NSNotificationCenter.defaultCenter().addObserver(TransitStopSelected, object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] note in
            if note.object !== self {
                if let index = self?.data.indexOf({ $0.primaryCode == (note.userInfo?[TransitStopPrimaryCode] as? String) }) {
                    self?.tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection:0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
                }
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var insets = self.tableView.contentInset
        insets.top = 0
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("StopCell", forIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? StopCell {
            cell.bind(self.data[indexPath.row])
        }
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? StopCell {
            cell.unbind()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSNotificationCenter.defaultCenter().postNotificationName(TransitStopSelected,
                                                                  object: self,
                                                                  userInfo: [TransitStopPrimaryCode:self.data[indexPath.row].primaryCode])
    }
}



