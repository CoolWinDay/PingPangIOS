//
//  CMDateUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CMDateUtils: NSObject {
    
}

extension Date {
    // ？？？？？？
    public func dateWithString(_ dateStr: String?) -> Date? {
        if let dateStr = dateStr {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            return formater.date(from: dateStr)
        }
        return nil
    }
    
    func dateToString() -> String? {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: self)
    }
}


