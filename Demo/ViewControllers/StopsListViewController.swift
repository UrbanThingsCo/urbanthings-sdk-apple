//
//  StopsListViewController.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import UIKit
import UTAPI

class StopsListViewController : UITableViewController {
 
    var updateObserver:AnyObject?
    var selectionObserver:AnyObject?
    var data:[UTAPI.TransitStop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateObserver = NotificationCenter.default.addObserver(name: StopDataUpdated, object: nil, queue: OperationQueue.main) { _ in
            self.data = StopsModel.sharedInstance.data
            self.tableView.reloadData()
        }
        
        self.selectionObserver = NotificationCenter.default.addObserver(name: TransitStopSelected, object: nil, queue: OperationQueue.main) { [weak self] note in
            if (note.object as AnyObject) !== self {
                if let index = self?.data.index(where: { $0.primaryCode == (note.userInfo?[TransitStopPrimaryCode] as? String) }) {
                    self?.tableView.selectRow(at: IndexPath(row: index, section:0), animated: true, scrollPosition: UITableViewScrollPosition.top)
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath as IndexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? StopCell {
            cell.bind(stop: self.data[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? StopCell {
            cell.unbind()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name(TransitStopSelected),
                                                                  object: self,
                                                                  userInfo: [TransitStopPrimaryCode:self.data[indexPath.row].primaryCode])
    }
}



