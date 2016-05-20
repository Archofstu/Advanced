//
//  String+Category.swift
//  Advanced
//
//  Created by Mac mini on 16/5/11.
//  Copyright © 2016年 cxy. All rights reserved.
//

import UIKit

extension String{
    func docDir() -> String {
        let docDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        return docDir.stringByAppendingPathComponent(self)
    }
}
