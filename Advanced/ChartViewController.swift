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
        //lineChart?.setVisibleXRangeMaximum(CGFloat(20))
        
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(tryToSave))
        
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
    
    @IBAction func simplify(sender: AnyObject) {
        let count = lineChart?.data?.dataSets[0].entryCount
        if count! > 3000{
            //let data = lineChart!.lineData
            var clearIndex = [Int]()
            for i in 0..<count! {
                if i % 2 == 1{
//                    let value = data!.dataSets[0].entryForIndex(i)!.value
//                    if abs((value - temp)/value) < 1 {
//                        temp = value
//                        print(i)
//                    }
//                    print(i)
                    clearIndex.append(i)
                }
            }

            print(lineChart?.data?.dataSets[0].entryCount)
            for j in 0..<clearIndex.count {
                //print(clearIndex[j])
                lineChart!.data!.dataSets[0].removeEntry(xIndex: clearIndex[j])
            }
            //print(lineChart?.data?.dataSets[0].entryCount)
            lineChart?.notifyDataSetChanged()
            //simplify(sender)
        }
    }



}
