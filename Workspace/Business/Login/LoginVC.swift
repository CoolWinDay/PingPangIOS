//
//  LoginVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/25.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class LoginVC: CMBaseVC {
    
    @IBOutlet weak var numText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var tileNumLab: UILabel!
    @IBOutlet weak var getCodeBtn: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var timer: Timer?
    var flag = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction
    func wxLogin() {
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self) { (userinfo, error) in
            if let theError = error {
                cmShowToast("登录失败：\(theError.localizedDescription)")
                print(theError.localizedDescription)
                return;
            }
            if let info = userinfo as? UMSocialUserInfoResponse {
                cmShowToast("登录成功：uid=\(info.uid!), name=\(info.name!)")
            }
        }
    }
    
    @IBAction
    func getCodeBtnClick() {
//        self.view.endEditing(true)
//        let phoneNumber = self.numText.text!.trimSpace()
//        if phoneNumber.isEmpty {
//            cmShowToast("请输入手机号")
//            return
//        }
//
//        if self.timer == nil {
//            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(resetGetCodeBtn), userInfo: nil, repeats: true)
//        }
//
//        self.tileNumLab.text = "\(flag)"
//        self.tileNumLab.isHidden = false
//
//        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: phoneNumber, zone: "+86", customIdentifier: nil) { (error) in
//            if error == nil {
//                cmShowToast("验证码已发送")
//            }
//            else {
//                cmShowToast(error?.localizedDescription)
//                self.getCodeBtn.isEnabled = true
//                self.tileNumLab.isHidden = true
//                self.timer?.invalidate()
//            }
//        }
        
    }
    
    @IBAction
    func registerBtnClick() {
//        let phoneNumber = self.numText.text!.trimSpace()
//        let codeNum = self.codeText.text!.trimSpace()
//        if codeNum.isEmpty {
//            cmShowToast("请输入验证码")
//            return
//        }
//        SMSSDK.commitVerificationCode(codeNum, phoneNumber: phoneNumber, zone: "+86") { (userInfo, error) in
//            if error == nil {
//                cmShowToast("验证成功")
//            }
//            else {
//                cmShowToast(error?.localizedDescription)
//            }
//        }
    }
    
    func resetGetCodeBtn() {
        self.tileNumLab.text = "\(flag)"
        if (flag <= 0) {
            flag = 60;
            self.getCodeBtn.isEnabled = true
            self.tileNumLab.isHidden = true
            self.timer?.invalidate()
            return
        }
        flag -= 1
    }

}
