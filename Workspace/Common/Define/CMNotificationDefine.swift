//
//  CMNotificationDefine.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    public static let UserNotificationHomeViewWillAppear = NSNotification.Name(rawValue:"UserNotificationHomeViewWillAppear")
    
    public static let NotificationUserLogin = NSNotification.Name(rawValue:"NotificationUserLogin")
    public static let NotificationUserLogout = NSNotification.Name(rawValue:"NotificationUserLogout")
    
    public static let kNFCheckedVenue = NSNotification.Name(rawValue:"kNFCheckedVenue")
    public static let kNFCheckedAuditor = NSNotification.Name(rawValue:"kNFCheckedAuditor")
    public static let kNFCheckedExam = NSNotification.Name(rawValue:"kNFCheckedExam")
}
