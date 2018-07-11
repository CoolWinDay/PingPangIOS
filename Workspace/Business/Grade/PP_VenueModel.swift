//
//  EE_VenueModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/12.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_VenueModel: CMJsonModel {
    var kid = ""
    var name = ""
    var charger = ""
    var phone = ""
    var province = ""
    var city = ""
    var county = ""
    var address = ""
    var introduce = ""
    var state = -1
    var venueImages: [UIImage] = []
    var AuthenticImages: [UIImage] = []
    
    var venueImage: [PP_ImageModel] = []
}
