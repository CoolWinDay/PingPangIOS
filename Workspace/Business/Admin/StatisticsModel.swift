//
//  StatisticsModel.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/7/23.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class StatisticsModel: CMJsonModel {

    var venueCountAll = 0
    var venueCountChecked = 0
    var venueCountUncheck = 0
    
    var auditorCountAll = 0
    var auditorCountChecked = 0
    var auditorCountUncheck = 0
    
    var examCountAll = 0
    var examCountWaiting = 0
    var examCountPassed = 0
    var examCountUnpass = 0
}
