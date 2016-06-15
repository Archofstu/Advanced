//
//  ChartDrawer.swift
//  Advanced
//
//  Created by Mac mini on 16/5/10.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import Charts
import SnapKit

class ChartDrawer: NSObject{
    
    static let drawer = ChartDrawer()
    
    class func shareDrawer() -> ChartDrawer{
        return drawer
    }

    func drawLineChart(inView view : UIView, withXvalues xValues:[String], yValues:[Float]) -> LineChartView{
        let lineChart = LineChartView()
        
        //描述文本
        lineChart.descriptionText = "Test Line Chart"
        lineChart.descriptionFont = UIFont.systemFontOfSize(15)
        //X轴标签位置
        lineChart.xAxis.labelPosition = .Bottom
        //动画设置
        lineChart.animate(xAxisDuration: 1, yAxisDuration: 1)
        //Y轴最小值
        //lineChart.leftAxis.axisMinValue = 0
        //lineChart.rightAxis.axisMinValue = 0
        //设置边框
        lineChart.drawBordersEnabled = true
        
        
        var chartDataEntries = [ChartDataEntry]()
        for i in 0...yValues.count - 1{
            let dataEntry = ChartDataEntry(value: Double(yValues[i]), xIndex: i)
            chartDataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: chartDataEntries, label: "test temperature")
        
        //设置端点大小
        chartDataSet.circleRadius = 3
        //设置y值显示保留小数点后一位
        let valueFormatter = NSNumberFormatter()
        valueFormatter.positiveFormat = "#.0"
        chartDataSet.valueFormatter = valueFormatter
        
        let data = LineChartData(xVals: xValues, dataSet: chartDataSet)
        
        lineChart.data = data
        
        view.addSubview(lineChart)
        
        lineChart.snp_makeConstraints { (make) in
            make.bottom.equalTo(lineChart.superview!.snp_bottom).offset(-55)
            make.top.equalTo(lineChart.superview!.snp_top).offset(130)
            make.leading.equalTo(lineChart.superview!.snp_leading).offset(10)
            make.trailing.equalTo(lineChart.superview!.snp_trailing).offset(-10)
        }
        
        lineChart.setVisibleXRangeMaximum(CGFloat(20))
        return lineChart
    }
        
    func refreshNewChart(lineChart:LineChartView, index:Int, time:String, value:Double){
        let entry = ChartDataEntry(value: value, xIndex: index)
        lineChart.lineData!.dataSets[0].addEntry(entry)
        lineChart.lineData?.addXValue(time)
        //随着点数增加自动调整视图
        lineChart.autoScaleMinMaxEnabled = true
        lineChart.setVisibleXRangeMaximum(CGFloat(20))
        if index>20 {
            lineChart.moveViewToX(CGFloat(index-20))
        }
        
        lineChart.notifyDataSetChanged()
        lineChart.invalidateIntrinsicContentSize()
    }

}
