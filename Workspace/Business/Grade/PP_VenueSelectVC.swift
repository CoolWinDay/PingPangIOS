//
//  PP_VenueSelectVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/18.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_VenueSelectVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择考场"
        
        loadData()
    }

    func loadData() {
        let province = "山西省"
        let city = "泉阳市"
        let county = "郊区"
        PP_GradeService.venueList(province: province, city: city, county: county) { (venueList) in
//            if let list = venueList {
//
//            }
        }
    }
}
