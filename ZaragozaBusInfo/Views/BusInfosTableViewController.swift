//
//  BusInfosTableViewController.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 03/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusInfosTableViewController: UITableViewController {
    
    // MARK: - Outlet's Actions
    
    @IBAction func refreshButtonClicked(sender: AnyObject) {
        fetchBusStopList()
    }
    
    // MARK: - Properties
    
    private var busStopList = [BusStopInfoModel]()
    private var operationsDictionary: NSMutableDictionary = NSMutableDictionary()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableViewAutomaticDimension
        // mute costraint error, if I had some plus time, I could fix this error
        NSUserDefaults.standardUserDefaults().setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        fetchBusStopList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper functions
    
    func fetchBusStopList() {
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.label.text = "fetching bus info list...";
        BusInfoController.busStopInfoList { (busStopList: [BusStopInfoModel]?) in
            self.fillArray(busStopList)
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
                self.loadAdditionalBusStopInfoForOnScreenRows()
                progressHUD.hideAnimated(true)
            })
        }
    }
    
    func fillArray(list: [BusStopInfoModel]?) {
        guard list?.count > 0 else {
            return
        }
        busStopList = list!
    }
    
    func loadAdditionalBusStopInfoForOnScreenRows() {
        let visiblePaths = self.tableView.indexPathsForVisibleRows
        for anIndexPath in visiblePaths! {
            let aBusStop = busStopList[anIndexPath.row]
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                BusInfoController.busInfoList(id: aBusStop.id, completion: { (busses: [BusInfoModel]?) in
                    dispatch_async(dispatch_get_main_queue()) {
                        let cell = self.tableView(self.tableView, cellForRowAtIndexPath: anIndexPath) as! BusInfoTableViewCell
                        cell.updatedBussesInfo(list: aBusStop.busArrivalsAsString(busses))
                        self.tableView.reloadRowsAtIndexPaths([anIndexPath], withRowAnimation: .Automatic)
                    }
                })
            }
        }
    }
}

// MARK: - Table View Data Source & Delegate

extension BusInfosTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busStopList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("busStopIdentifier", forIndexPath: indexPath) as! BusInfoTableViewCell
        
        // Configure the cell...
        let aBusStop = busStopList[indexPath.row]
        cell.configureCellViews(aBusStop.id,
                                name: aBusStop.title)
        let imageURL = BusInfoController.busStopImageURL(lat: aBusStop.lat, lon: aBusStop.lon)
        if  imageURL != nil {
            cell.stopImageView.af_setImageWithURL(imageURL!)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
}

// MARK: - UIScrollViewDelegate

extension BusInfosTableViewController {
    // -------------------------------------------------------------------------------
    //	scrollViewDidEndDragging:willDecelerate:
    //  Load additional info for all onscreen rows when scrolling is finished.
    // -------------------------------------------------------------------------------
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadAdditionalBusStopInfoForOnScreenRows()
        }
    }
    
    // -------------------------------------------------------------------------------
    //	scrollViewDidEndDecelerating:scrollView
    //  When scrolling stops, proceed to load the app icons that are on screen.
    // -------------------------------------------------------------------------------
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        loadAdditionalBusStopInfoForOnScreenRows()
    }
    
}
