//
//  PP_ExamineeModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/20.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import HandyJSON

class PP_ExamineeModel: CMJsonModel {
    var name = ""
    var sex = ""
    var age = ""
    var phone = ""
    var idcard = ""
    var grade = ""
    var avatarImage: PP_ImageModel?

//    func mapping(mapper: HelpingMapper) {
//        mapper >>> self.avatarImage
//    }
}
