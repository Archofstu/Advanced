//
//  UserAccount.swift
//  Advanced
//
//  Created by  cxy on 16/4/24.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    var username:String = ""
    var password:String = ""
    var id:Int = 0
    
    init(dic:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    //override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    ///类常量定义---app中的caches文件夹地址
    static let cachesPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last! as NSString
    static let filePath = cachesPath.stringByAppendingPathComponent("user.plist")
    
    func saveAccount(){
        print(UserAccount.filePath)
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    class func readAccount() -> UserAccount? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.filePath) as? UserAccount
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(id, forKey: "id")
    }
    
    required init?(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObjectForKey("username") as! String
        password = aDecoder.decodeObjectForKey("password") as! String
        id = aDecoder.decodeObjectForKey("id") as! Int
    }
    
    override var description: String{
        return "\(username)---\(password)---\(id)"
    }

}
