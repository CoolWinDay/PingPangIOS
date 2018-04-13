//
//  NotificationVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/6.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class NotificationVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction
    func remoteNotification() {
        
    }

    @IBAction
    func localNotification() {
        // 1.创建本地通知
        let localNote = UILocalNotification();
        
        // 2.设置本地通知的内容
        // 2.1.设置通知发出的时间
        localNote.fireDate = Date.init(timeIntervalSinceNow: 3.0)
        // 2.2.设置通知的内容
        localNote.alertBody = "在干吗?"
        // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
        localNote.alertAction = "解锁"
        // 2.4.决定alertAction是否生效
        localNote.hasAction = false
        // 2.5.设置点击通知的启动图片
        localNote.alertLaunchImage = "bulb"
        // 2.6.设置alertTitle
        if #available(iOS 8.2, *) {
            localNote.alertTitle = "你有一条新通知"
        }
        // 2.7.设置有通知时的音效
        localNote.soundName = "buyao.wav"
        // 2.8.设置应用程序图标右上角的数字
        localNote.applicationIconBadgeNumber = 99
        // 2.9.设置额外信息
        localNote.userInfo = ["type" : "1"]
        
        // 3.调用通知
        UIApplication.shared.scheduleLocalNotification(localNote)
    }
}
