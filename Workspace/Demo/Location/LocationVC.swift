//
//  LocationVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/6.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class LocationVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction
    func currentLocation() {
        CMLocationManager.sharedInstance.currentLoaction { (location) in
            if let location = location {
                UIAlertView.alertWith(title: "经度：\(location.coordinate.longitude)\n纬度：\(location.coordinate.latitude)")
            }
            else {
                UIAlertView.alertWith(title: "定位失败")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
