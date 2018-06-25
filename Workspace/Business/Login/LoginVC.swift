//
//  LoginVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/25.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class LoginVC: CMBaseVC {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction
    func doLogin() {
        self.view.endEditing(true)
        
        guard let username = nameText.text else {
            cmShowToast("请输入账号")
            return
        }
        guard let pwd = pwdText.text else {
            cmShowToast("请输入密码")
            return
        }
        
        ForumService.loginUser(username: username, password: pwd) { (model) in
            if let model = model {
                model.save2Cache()
                cmShowToast("登录成功")
                NotificationCenter.default.post(name: .NotificationUserLogin, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
            else {
                cmShowToast("登录失败")
            }
        }
    }
    
    @IBAction
    func doRegist() {
        ForumService.registUser(username: "", password: "") { (model) in
            
        }
    }
    
    @IBAction
    func doClose() {
        self.dismiss(animated: true) {
            
        }
    }
}
