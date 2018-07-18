//
//  EE_VenueModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/12.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import HandyJSON

class PP_AuditorModel: CMJsonModel {
    var kid = ""
    var name = ""
    var sex = ""
    var age = ""
    var phone = ""
    var idcard = ""
    var introduce = ""
    var venueid = ""
    var state = -1
    var avatarImage: PP_ImageModel?
    var certificateImage: [PP_ImageModel] = []
    var venue: PP_VenueModel?
    
    
//    func mapping(mapper: HelpingMapper) {
//        mapper >>> self.avatarImage
//        mapper >>> self.certificateImages
//    }
}
