//
//  CMUpdateManager.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CMUpdateManager: NSObject {
    
    static let sharedInstance = CMUpdateManager()
    override private init() {
        super.init()
    }
    
    static var testNum = 0      // 测试2次
    
    class func checkUpdate() {
        let updateType = UserDefaults.getUserDefaultsString(UserDefaults.UDKey_UpdateType)
        if updateType == UserDefaults.UDValue_UpdateTypeForce {
            // 强制升级
            if CMUpdateManager.isNeedUpdate() {
                UIAlertView.alertWith(title: "强制升级", message: "模拟点击两次之后不再弹出", cancelButton: nil, okAction: { (alert) in
                    CMUpdateManager.gotoAppstore()
                    if CMUpdateManager.testNum < 1 {
                        CMUpdateManager.testNum += 1
                        CMUpdateManager.checkUpdate()
                    }
                })
            }
            
        }
        else if updateType == UserDefaults.UDValue_UpdateTypeOptional {
            // 可选升级，取消过了的话当天不再提示
            if CMUpdateManager.isNeedUpdate() {
                let cancelDate = UserDefaults.getUserDefaultsString("UDK_UpdateCancelDate")
                if cancelDate == nil || cancelDate!.compare(Date().dateToString()!) == .orderedAscending {
                    UIAlertView.alertWith(title: "是否需要升级？", okAction: { (alert) in
                        CMUpdateManager.gotoAppstore()
                    }, cancelAction: { (alert) in
                        UserDefaults.setUserDefaultsString(Date().dateToString(), forKey: "UDK_UpdateCancelDate")
                    })
                }
            }
        }
    }
    
    class func gotoAppstore() {
        let appleId = "1048321627"
        let urlStr = "itms-apps://itunes.apple.com/cn/app/yi-jie-qu/id\(appleId)?mt=8"
        UIApplication.shared.openURL(URL(string: urlStr)!)
    }
    
    class func isNeedUpdate() -> Bool {
        let serverVersion = UserDefaults.getUserDefaultsString(UserDefaults.UDKey_UpdateVersion)
        if let serverVersion = serverVersion {
            let localVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
            return localVersion.compare(serverVersion) == .orderedAscending
        }
        return true
    }
}
