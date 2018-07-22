//
//  PP_ExamModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/20.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ExamModel: CMJsonModel {
    var kid = ""
    var user_id = ""
    var venue_id = ""
    var auditor_id = ""
    var examinee_id = ""
    var exam_date = ""
    var state = -1
    var venue: PP_VenueModel?
    var auditor: PP_AuditorModel?
    
    var name = ""
    var sex = ""
    var age = ""
    var phone = ""
    var idcard = ""
    var grade = "0"
    var avatarImage: PP_ImageModel?
}
