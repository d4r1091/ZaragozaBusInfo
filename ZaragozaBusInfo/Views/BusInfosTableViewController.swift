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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableViewAutomaticDimension
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
        if  let url = BusInfoController.busStopImageURL(lat: aBusStop.lat, lon: aBusStop.lon){
            cell.stopImageView.af_setImageWithURL(url)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
}
