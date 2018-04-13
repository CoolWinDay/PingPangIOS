//
//  CMApplication.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/7.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CMApplication: UIApplication {
    override init() {
        super.init()
        self.initApplication()
    }
    
    var isHomeViewAppeared = false
    
    func initApplication() {
        NotificationCenter.default.addObserver(self, selector: #selector(appFinishLaunching(notification:)), name: .UIApplicationDidFinishLaunching, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground(notification:)), name: .UIApplicationWillEnterForeground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeViewWillAppear(notification:)), name: .UserNotificationHomeViewWillAppear, object: nil)
        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin:) name:NotificationUserLogin object:nil];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectProject:) name:NotificationProjectChanged object:nil];
    }
    
    func appFinishLaunching(notification: Notification) {
        CMUpdateManager.checkUpdate()
    }
    
    func appWillEnterForeground(notification: Notification) {
        
    }
    
    // 首页显示
    func homeViewWillAppear(notification: Notification) {
        
        if !self.isHomeViewAppeared {
            // 只第一次首页显示执行
            
            self.isHomeViewAppeared = true
        }
    }
    
}
