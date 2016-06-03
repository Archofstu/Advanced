//
//  RealtimeViewController.swift
//  Advanced
//
//  Created by  cxy on 16/5/19.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import Charts

class RealtimeViewController: UIViewController {
    var lineChart:LineChartView?
    
    var timeFormmater : NSDateFormatter = {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        return timeFormatter
    }()
    
    ///采样间隔时间
    var timeInterval:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lineChart = ChartDrawer.shareDrawer().drawLineChart(inView: view, withXvalues: ["first"], yValues: [20.0])
        
        self.lineChart = lineChart
        let timer = NSTimer(timeInterval: timeInterval!, target: self, selector: #selector(realtimeRefresh), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        // Do any additional setup after loading the view.
    }
    
    var index = 1
    
    func realtimeRefresh(){
        let now = NSDate()
        let timeStr = timeFormmater.stringFromDate(now)
        ChartDrawer.shareDrawer().refreshNewChart(lineChart!, index: index, time: timeStr)
        index += 1
    }

}
