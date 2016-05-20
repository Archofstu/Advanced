//
//  ExperimentViewController.swift
//  Advanced
//
//  Created by Mac mini on 16/5/5.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ExperimentViewController: UIViewController{

    @IBOutlet weak var experimentItemTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    lazy var dateFormatter : NSDateFormatter = {
        let format = NSDateFormatter()
        format.dateFormat = "yy-MM-dd HH:mm"
        return format
    }()
    
    ///实验项目
    let experimentItems = ["Temperature", "Rainfall", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(close))
        
        configureTextField()
        // Do any additional setup after loading the view.
    }
    
    func configureTextField(){
        experimentItemPickerView.selectRow(experimentItems.count - 1, inComponent: 0, animated: true)
        experimentItemTF.inputView = experimentItemPickerView
        
        timeTF.inputView = timePickerView
    }
    
    ///实验项目选择器
    lazy var experimentItemPickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.lightTextColor()
        return pickerView
    }()
    
    ///时间选择器
    lazy var timePickerView : UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .DateAndTime
        pickerView.backgroundColor = UIColor.lightTextColor()
        pickerView.minimumDate = NSDate()
        pickerView.addTarget(self, action: #selector(timeChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        return pickerView
    }()
    
    func timeChanged(sender:AnyObject){
        let picker = sender as! UIDatePicker
        let dateTime = dateFormatter.stringFromDate(picker.date)
        timeTF.text = dateTime
    }
    
    func close() {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func goExperiment(sender: AnyObject) {
//        let now = NSDate()
//        let nowStr = dateFormatter.stringFromDate(now)
//        let tableName = "Temperature \(nowStr)"
//        SQLiteManager.shareManager().openDB("db", withTable: tableName)
//        
//        for i in 0...20 {
//            if i % 100 == 0 {
//                print("-----\(i)-------")
//            }
//            let time = now.dateByAddingTimeInterval(Double(i) * 3600.0)
//            let timeStr = dateFormatter.stringFromDate(time)
//            let dic:[String:AnyObject] = ["temperatureNum" : Double(Double(arc4random() % 5) + 20.8), "time" : timeStr]
//            let temperature = Temperature(dic: dic)
//            temperature.insert(tableName)
//        }
//        Alamofire.request(.GET, "http://localhost:3000/temps").responseJSON { (response) in
//            let results = response.result.value as! [[String:AnyObject]]
//            for result in results{
//                let temperature = Temperature(dic: result)
//                temperature.insert(tableName)
//            }
//        }
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = .Text
        hud.labelText = "发送实验请求成功"
        hud.hide(true, afterDelay: 2)
        
        let realtimeVC = storyboard?.instantiateViewControllerWithIdentifier("realtime") as! RealtimeViewController
        navigationController?.pushViewController(realtimeVC, animated: true)
    }

}

// MARK: - 实现选择器的代理方法
extension ExperimentViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return experimentItems.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return experimentItems[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        experimentItemTF.text = experimentItems[row]
    }
}
