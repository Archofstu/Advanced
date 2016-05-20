//
//  MenuViewController.swift
//  Advanced
//
//  Created by  cxy on 16/4/25.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    let options = ["实验","查看记录","退出账号"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bounces = false
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return options.count
        default:
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = "用户:\(UserAccount.readAccount()!.username)"
            cell.imageView?.image = UIImage(named: "man_64")
            
            cellImagefixed(cell)
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = options[indexPath.row]
            cell.imageView?.image = UIImage(named: "option_\(indexPath.row + 1)")
            
            cellImagefixed(cell)
        }
        // Configure the cell...
        
        return cell
    }
    
    ///固定cell的图片大小
    func cellImagefixed(cell: UITableViewCell){
        let imageSize = CGSizeMake(20, 20)
        UIGraphicsBeginImageContext(imageSize)
        let imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height)
        cell.imageView?.image?.drawInRect(imageRect)
        cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                slideMenuController()?.closeLeft()
            }
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            //实验
            case 0:
                slideMenuController()?.closeLeft()
                let experimentVC = storyboard?.instantiateViewControllerWithIdentifier("experiment") as! ExperimentViewController
                let naviVC = UINavigationController(rootViewController: experimentVC)
                presentViewController(naviVC, animated: true, completion: nil)
                break
            //查看记录
            case 1:
                slideMenuController()?.closeLeft()
                let recordVC = storyboard?.instantiateViewControllerWithIdentifier("record") as! RecordViewController
                (slideMenuController()?.mainViewController as! UINavigationController).pushViewController(recordVC, animated: true)
                break
            //"退出账号"
            case 2:
                dismissViewControllerAnimated(true, completion: nil)
                break
            default:
                print("default")
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
