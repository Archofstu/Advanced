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
        timeFormatter.dateFormat = "yy-MM-dd HH:mm"
        return timeFormatter
    }()
    
    ///采样间隔时间
    var timeInterval:Double?
    ///实验保存表名
    var experimentTableName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lineChart = ChartDrawer.shareDrawer().drawLineChart(inView: view, withXvalues: ["first"], yValues: [20.0])
        let tableCreateTime = timeFormmater.stringFromDate(NSDate())
        experimentTableName = "Temperature \(tableCreateTime)"
        SQLiteManager.shareManager().openDB("db", withTable: "Temperature \(tableCreateTime)")
        
        self.lineChart = lineChart
        let timer = NSTimer(timeInterval: timeInterval!, target: self, selector: #selector(realtimeRefresh), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        // Do any additional setup after loading the view.
    }
    
    var index = 1
    
    func realtimeRefresh(){
        let now = NSDate()
        let timeStr = timeFormmater.stringFromDate(now)
        let value = Double(arc4random() % 5) + 20.0
        ChartDrawer.shareDrawer().refreshNewChart(lineChart!, index: index, time: timeStr, value: value)
        let dic = ["temperatureNum":value, "time":timeStr]
        let temperature = Temperature(dic: dic as! [String : AnyObject])
        temperature.insert(experimentTableName!)
        index += 1
    }

}
