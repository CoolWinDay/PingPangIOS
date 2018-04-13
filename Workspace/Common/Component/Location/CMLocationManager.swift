//
//  CMLocationManager.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/6.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import CoreLocation

class CMLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = CMLocationManager()
    override private init() {
        super.init()
    }
    
    let locationManager = CLLocationManager()
    var lock = NSLock()
    var locationMethod: (CLLocation?) -> () = {location in }
    var isLocated = false
    
    func currentLoaction(_ location: @escaping (CLLocation?) -> ()) {
        guard isRightLocation() else {
            UIAlertView.alertWith(title: "请开启定位权限");
            return;
        }
        
        isLocated = false
        locationMethod = location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //定位精确度（最高）一般有电源接入，比较耗电
        //kCLLocationAccuracyNearestTenMeters;//精确到10米
        locationManager.distanceFilter = 50 //设备移动后获得定位的最小距离（适合用来采集运动的定位）
        locationManager.requestWhenInUseAuthorization()//弹出用户授权对话框，使用程序期间授权（ios8后)
        //requestAlwaysAuthorization;//始终授权
        locationManager.startUpdatingLocation()
        print("开始定位》》》")
    }
    
    /**
     *  CLlocationDelegate
     */
    //委托传回定位，获取最后一个
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        lock.lock()
        if !isLocated {
            locationMethod(locations.last)
            isLocated = true
        }
        lock.unlock()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        lock.lock()
        if !isLocated {
            locationMethod(nil)
            isLocated = true
        }
        lock.unlock()
        print("定位出错拉！！\(error)")
    }
}
