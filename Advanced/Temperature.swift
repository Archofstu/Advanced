//
//  Temperature.swift
//  Advanced
//
//  Created by  cxy on 16/5/4.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

class Temperature: NSObject {
    var temperatureNum:Float = 0.0
    var time:String = ""
    
    init(dic:[String:AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    ///插入数据
    func insert(tableName:String) -> Bool{
        let sql = "INSERT INTO \"\(tableName)\"\n" +
                "(temperature, time)" +
                "VALUES(\n" +
                "\(temperatureNum),\"\(time)\");"
        
        return SQLiteManager.shareManager().db.executeUpdate(sql, withArgumentsInArray: nil)
    }
    
    ///读取整个表的数据
    class func readRecord(tableName:String) -> [Temperature]{
        let sql = "SELECT * FROM \"\(tableName)\""
        let res = SQLiteManager.shareManager().db.executeQuery(sql, withArgumentsInArray: nil)
        
        var records = [Temperature]()
        while res!.next(){
            let tempNum = res?.doubleForColumn("temperature")
            let time = res?.stringForColumn("time")
            let temperature = Temperature(dic: ["temperatureNum":tempNum!, "time":time!])
            records.append(temperature)
        }
        return records
    }
    
    ///读取所有表名
    class func readTableNames() -> [String]{
        let sql = "SELECT name FROM sqlite_master WHERE TYPE=\"table\""
        
        let res = SQLiteManager.shareManager().db.executeQuery(sql, withArgumentsInArray: nil)
        var tableName = [String]()

        while res!.next() {
            let name = res?.stringForColumn("name")
            tableName.append(name!)
        }
        return tableName
    }
    
    
    
}
