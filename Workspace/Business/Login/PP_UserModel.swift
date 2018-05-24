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
    
    func save2UserDefaults() {
        let jsonStr = self.toJSONString()
        UserDefaults.setUserDefaultsString(jsonStr, forKey: UserDefaults.UDK_UserModel)
    }
    
    class func modelWithUserDefaults() -> PP_UserModel? {
        let jsonStr = UserDefaults.getUserDefaultsString(UserDefaults.UDK_UserModel)
        let model = PP_UserModel.deserialize(from: jsonStr)
        return model
    }
}
