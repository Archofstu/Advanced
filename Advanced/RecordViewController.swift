//
//  RecordViewController.swift
//  Advanced
//
//  Created by Mac mini on 16/5/10.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

class RecordViewController: UITableViewController {

    var tableNames : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "记录列表"
        tableNames = Temperature.readTableNames()
        tableView.reloadData()
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
    
    //MARK: - table view delegate
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let alert = UIAlertController(title: "警告", message: "确认删除该记录？", preferredStyle: .ActionSheet)
            let action0 = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let action1 = UIAlertAction(title: "确认", style: .Default, handler: { (_) in
                Temperature.deleteTable(self.tableNames![indexPath.row])
                self.tableNames!.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
            alert.addAction(action0)
            alert.addAction(action1)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}
