//
//  PP_ImageModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/19.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import HandyJSON

class PP_ImageModel: HandyJSON {
    var name = ""
    var path = ""
    var module = 0     // 1：考场，2：考官，3：考生
    var type = 0       // 1：场馆图片，2：认证图片，3：头像图片
    
    
    var image: UIImage?
    var imageUrl: String {
        get {
            return "\(PP_BaseService.gradeServer)/\(path)/\(name)"
        }
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper >>> self.image
    }
    
    required init() {}
}
