//
//  AppDelegate.swift
//  CommonSwift
//
//  Created by lipeng on 16/9/7.
//  Copyright © 2016年 com.jsinda. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = CMRootNavigation(rootViewController: CMRootTabBar())
        self.window?.makeKeyAndVisible()
        
        // 键盘管理
        IQKeyboardManager.sharedManager().enable = true
        
        // 短信验证码
//        SMSSDK.registerApp("173f87709381d", withSecret: "69988802391e4d4be0214cbfd1dc7299")
//        SMSSDK.enableAppContactFriends(false)
        
        // 友盟分享
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "561b44cf67e58e6189001c30"
        UMSocialManager.default().setPlaform(.wechatSession, appKey: "wxe22cb13bb75e9a71", appSecret: "35fcd7b29a9b268eae4ee5d034b04e96", redirectURL: nil)
        UMSocialManager.default().setPlaform(.sina, appKey: "3765687013", appSecret: "c493ae3de0e6082d6918b506579dd2b8", redirectURL: nil)
        UMSocialManager.default().setPlaform(.QQ, appKey: "1104814405", appSecret: nil, redirectURL: nil)
        
        // 友盟推送
        UMessage.start(withAppkey: "561b44cf67e58e6189001c30", launchOptions: launchOptions, httpsenable: true)
        UMessage.registerForRemoteNotifications()
        
        //iOS10必须加下面这段代码。
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { (granted, error) in
                if granted {
                    // 点击允许, 这里可以添加一些自己的逻辑
                    
                }
                else {
                    // 点击不允许, 这里可以添加一些自己的逻辑
                    
                }
            })
        }
        
        //打开日志，方便调试(发布时去掉)
        UMessage.setLogEnabled(true)
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let nsdataStr = NSData.init(data: deviceToken)
        let token = nsdataStr.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        print(token)
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            self.handleOpenUrl(url)
        }
        return result;
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        if !result {
            self.handleOpenUrl(url)
        }
        return result;
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, options: options)
        if !result {
            self.handleOpenUrl(url)
        }
        return result;
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        self.handleRemoteNotification(userInfo)
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        self.handleLocalNotification(notification.userInfo)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        let trigger = notification.request.trigger
        
        if trigger != nil && trigger!.isKind(of: UNPushNotificationTrigger.self) {
            // 应用处于前台时的远程推送接受
            self.handleRemoteNotification(userInfo)
            UMessage.didReceiveRemoteNotification(userInfo)
        }
        else {
            //应用处于前台时的本地推送接受
            self.handleLocalNotification(userInfo)
        }
        
        // 当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler([.badge, .alert, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let trigger = response.notification.request.trigger
        if trigger != nil && trigger!.isKind(of: UNPushNotificationTrigger.self) {
            UMessage.didReceiveRemoteNotification(userInfo)
            self.goMessagePage(userInfo)
        }
        else {
            //应用处于后台时的本地推送接受
            self.goMessagePage(userInfo)
        }
    }
    
    func handleRemoteNotification(_ userInfo: [AnyHashable : Any]) {
        UMessage.setAutoAlert(false)
        
        if UIApplication.shared.applicationState == .active {
            UIAlertView.alertWith(title: "标题", message: "远程通知", okButton: "确定", okAction: { (alert) in
                
            })
        }
    }
    
    func handleLocalNotification(_ userInfo: [AnyHashable : Any]?) {
        if UIApplication.shared.applicationState == .active {
            UIAlertView.alertWith(title: "标题", message: "本地通知", okButton: "确定", okAction: { (alert) in
                
            })
        }
    }
    
    func handleOpenUrl(_ url: URL) {
        if url.absoluteString.hasPrefix("cmWidgetDemo") {
            let alert = UIAlertController.init(title: "Tip", message: "Widget点击了open按钮", preferredStyle: UIAlertControllerStyle.alert)
            let tureAction = UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.cancel, handler: { (cancle  ) in
                
            })
            alert.addAction(tureAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated:true, completion: {
                
            })
        }
    }
    
    func goMessagePage(_ userInfo: [AnyHashable : Any]) {
        guard cmTopMostViewController()!.isKind(of: NotificationVC.self) else {
            cmPushViewController("NotificationVC")
            return
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

