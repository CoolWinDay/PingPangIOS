//
//  DemoHomeVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/9.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate
import Moya
import Alamofire

class DemoHomeVC: CMBaseVC {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    let myString = "abc[mobcent_phiz=http://www.pingpangwang.com/static/image/smiley/default/smile.gif]def[mobcent_phiz=http://www.pingpangwang.com/static/image/smiley/default/cry.gif]ghi"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = myString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        NotificationCenter.default.post(name: .UserNotificationHomeViewWillAppear, object: nil)
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction
    func btnPredded() {
        let username = "18610249533"
        let password = "123456"
        ForumService.registUser(username: username, password: username) { (model) in
            // 注册成功，登录
            ForumService.loginUser(username: username, password: password, { (model) in
                
            })
        }
        
        
        self.label.attributedText = myString.handleMobcentGifText()
        
//        ForumService.forumList { (forumList) in
//
//        }
        
//        let url = "http://www.pingpangwang.com/mobcent/app/web/index.php?r=forum/forumlist"
//        Alamofire.request(url).responseData(completionHandler: { (response) in
//            let json = JSON(data: response.result.value!)
//            print(json)
//
//            let modelList = [PP_ForumModel].deserialize(from: json.rawString(), designatedPath: "list")
//        })
        
        
//        let date = "2014-09-03".date(format: DateFormat.custom("yyyy-MM-dd"))?.absoluteDate
//        if let date = date {
//            let string = date.string(format: DateFormat.custom("yyyy-MM-dd"))
//            let month = date.month
//        }
        
//        cmSetUserDefaults(string: "aaa", forKey: "testKey")
//        let testValue = cmGetUserDefaultsString(forKey: "testKey")
//        UIAlertView.alertWith(title: testValue, okAction: { (alert) in
//            
//        })
        
//        UIAlertView.alertWith(title: "aaaa")
//        
//        let button = UIButton()
//        button.addAction { (button) in
//            
//        }
        
//        UIAlertView.alertWith(title: "title", okButton: "ok") { (alert) in
//            
//        }
//        UIAlertView.alertWith(title: "title") { (alert) in
//            self.title = alert.title
//        }
        
//        let webVC = CMWebVC()
//        webVC.title = "WebView"
//        webVC.webUrl = "https://www.baidu.com"
//        cmPushViewController(webVC)
        
//        cmPushViewController("CMWebVC") { (vc) in
//            vc.title = "WebView"
//            if let vcInstance = vc as? CMWebVC {
//                vcInstance.webUrl = "https://www.baidu.com"
//            }
//        }
    }
}
