//
//  ChartViewController.swift
//  Advanced
//
//  Created by  cxy on 16/5/14.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    var xValues:[String]?
    var yValues:[Float]?
    var lineChart:LineChartView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart = ChartDrawer.shareDrawer().drawLineChart(inView: view, withXvalues: xValues!, yValues: yValues!)
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(tryToSave))
        
        title = "Record"
        
    }
    
    func tryToSave(){
        let alert = UIAlertController(title: "提示", message: "是否保存该图表", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let yesAction = UIAlertAction(title: "是", style: .Default) { (_) in
            self.lineChart?.saveToCameraRoll()
        }
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        presentViewController(alert, animated: true, completion: nil)
    }

}
