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
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var findPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameText.layer.borderColor = UIColor.ColorTextLight().cgColor
        nameText.layer.borderWidth = 1.0
        
        
        if let model = PP_UserModel.modelWithUserDefaults() {
            let a = model.token
        }
        
    }
    
    @IBAction
    func doLogin() {
        guard let username = nameText.text else {
            cmShowToast("请输入账号")
            return
        }
        guard let pwd = pwdText.text else {
            cmShowToast("请输入密码")
            return
        }
        
        ForumService.loginUser(username: username, password: pwd) { (model) in
            guard let model = model else {
                cmShowToast("用户名或密码错误")
                return
            }
            
            model.save2UserDefaults()
            cmShowToast("登录成功")
        }
    }
    
    @IBAction
    func doRegist() {
        
    }
    
    @IBAction
    func doFindPwd() {
        
    }
}
