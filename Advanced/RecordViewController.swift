//
//  RecordViewController.swift
//  Advanced
//
//  Created by Mac mini on 16/5/10.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

class RecordViewController: UITableViewController {

    var tableNames : [String]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "记录列表"
        tableNames = Temperature.readTableNames()
        //取消多余的cell显示
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (tableNames?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recordCell")
        cell?.textLabel?.text = tableNames![indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let temps = Temperature.readRecord(tableNames![indexPath.row])
        var xValues = [String]()
        var yValues = [Float]()
        for temp in temps{
            xValues.append(temp.time)
            yValues.append(temp.temperatureNum)
        }
        let chartVC = storyboard?.instantiateViewControllerWithIdentifier("chart") as! ChartViewController
        chartVC.xValues = xValues
        chartVC.yValues = yValues
        navigationController?.pushViewController(chartVC, animated: true)
        
    }
}
