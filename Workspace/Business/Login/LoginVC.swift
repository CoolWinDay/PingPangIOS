//
//  LoginVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/25.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class LoginVC: CMBaseVC {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var registView: UIView!
    
    @IBOutlet weak var nameText0: UITextField!
    @IBOutlet weak var pwdText0: UITextField!
    
    @IBOutlet weak var nameText1: UITextField!
    @IBOutlet weak var pwdText1: UITextField!
    @IBOutlet weak var rePwdText1: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction
    func doLogin() {
        self.view.endEditing(true)
        
        guard let username = nameText0.text, username.count > 0 else {
            cmShowToast("请输入账号")
            return
        }
        guard let pwd = pwdText0.text, pwd.count > 0 else {
            cmShowToast("请输入密码")
            return
        }
        
        self.loginWith(username: username, password: pwd)
    }
    
    func loginWith(username: String, password: String) {
        ForumService.loginUser(username: username, password: password) { (model) in
            if let model = model {
                model.save2Cache()
                cmShowToast("登录成功")
                NotificationCenter.default.post(name: .NotificationUserLogin, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction
    func doRegist() {
        self.view.endEditing(true)
        
        guard let username = nameText1.text, username.count > 0 else {
            cmShowToast("请输入账号")
            return
        }
        guard let pwd = pwdText1.text, pwd.count > 0 else {
            cmShowToast("请输入密码")
            return
        }
        guard let rePwd = rePwdText1.text, rePwd.count > 0 else {
            cmShowToast("请确认密码")
            return
        }
        if pwd != rePwd {
            cmShowToast("两次输入密码不一致")
            return
        }
        
        ForumService.registUser(username: username, password: pwd) { (model) in
            self.loginWith(username: username, password: pwd)
        }
    }
    
    @IBAction
    func toLoginView() {
        self.loginView.isHidden = false
        self.registView.isHidden = true
    }
    
    @IBAction
    func toRegistView() {
        self.loginView.isHidden = true
        self.registView.isHidden = false
    }
    
    @IBAction
    func doClose() {
        self.dismiss(animated: true) {
            
        }
    }
}
