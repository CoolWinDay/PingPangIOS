//
//  PP_UserModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/24.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import SwiftyJSON

class PP_UserModel: CMJsonModel {
    var token = ""
    var secret = ""
    var uid = ""
    var userName = ""
    var avatar = ""
    var userTitle = ""
    var groupid = ""
    var role = 0
    
    func save2Cache() {
        let jsonStr = self.toJSONString()
        UserDefaults.setUserDefaultsString(jsonStr, forKey: UserDefaults.UDK_UserModel)
    }
    
    func isAdminUser() -> Bool {
        if let gid = Int(groupid) {
            return gid <= 2
        }
        return false
    }
    
    func isVenueUser() -> Bool {
        return role == 3
    }
    
    func isAuditorUser() -> Bool {
        return role == 2
    }
    
    func isExamUser() -> Bool {
        return role == 1
    }
    
//    class func isAdminUser() -> Bool {
//        if let model = modelWithCache() {
//            if let gid = Int(model.groupid) {
//                return gid <= 2
//            }
//        }
//        return false
//    }
    
    class func removeLoginCache() {
        UserDefaults.setUserDefaultsString("", forKey: UserDefaults.UDK_UserModel)
    }
    
    class func modelWithCache() -> PP_UserModel? {
        let jsonStr = UserDefaults.getUserDefaultsString(UserDefaults.UDK_UserModel)
        let model = PP_UserModel.deserialize(from: jsonStr)
        return model
    }
    
    class func userToken() -> String {
        if let model = modelWithCache() {
            return model.token
        }
        return ""
    }
}
