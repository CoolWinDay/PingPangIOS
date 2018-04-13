//
//  CMNetWorkManager.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/6.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import Alamofire

class CMNetWorkManager: NSObject {
    
    // 单例
    static let manager = NetworkReachabilityManager()
    override private init() {
        super.init()
    }
    
    class func isReachable() -> Bool {
        return manager!.isReachable
    }
    
    class func isReachableOnEthernetOrWiFi() -> Bool {
        return manager!.isReachableOnEthernetOrWiFi
    }
    
    class func isReachableOnWWAN() -> Bool {
        return manager!.isReachableOnWWAN
    }
}
