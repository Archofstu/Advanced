//
//  SQLiteManager.swift
//  Advanced
//
//  Created by Mac mini on 16/5/11.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    static let sqlManager = SQLiteManager()
    //创建单例
    class func shareManager() -> SQLiteManager{
        return sqlManager
    }
    
    var db : FMDatabase = {
        let db = FMDatabase(path: "db.sqlite".docDir())
        db.open()
        return db
    }()
    
    func openDB(dbName:String, withTable tableName:String) -> Bool {
        let dbPath = "\(dbName).sqlite".docDir()
        if !db.open(){
            return false
        }
        else{
            print(dbPath)
            createTable(tableName)
            return true
        }
    }
    
    func createTable(tableName:String) -> Bool {
        //需要对双引号用\进行转意
        let sql = "CREATE TABLE IF NOT EXISTS \"\(tableName)\"(\n" +
                    "id INTEGER PRIMARY KEY,\n" +
                    "temperature REAL,\n" +
                    "time TEXT\n" +
                    ");\n"
        return db.executeUpdate(sql, withArgumentsInArray: nil)
    }
}
