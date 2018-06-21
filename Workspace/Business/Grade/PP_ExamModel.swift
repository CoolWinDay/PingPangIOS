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
    var exam_grade = ""
    var exam_time = ""
    var examinee: PP_ExamineeModel?
}
