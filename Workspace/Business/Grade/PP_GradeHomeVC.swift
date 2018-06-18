//
//  PP_GradeHomeVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/17.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_GradeHomeVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction
    func applyVenue() {
        if checkLogin() {
            cmPushViewController("PP_GradeVenueApplyVC")
        }
        else {
            cmShowLogin(animated: true)
        }
    }
    
    @IBAction
    func applyAuditor() {
        if checkLogin() {
            cmPushViewController("PP_AuditorApplyVC")
        }
        else {
            cmShowLogin(animated: true)
        }
    }
    
    @IBAction
    func applyExam() {
        if checkLogin() {
            cmPushViewController("PP_GradeVenueApplyVC")
        }
        else {
            cmShowLogin(animated: true)
        }
    }
    
    func checkLogin() -> Bool {
        return true
        
//        let token = PP_UserModel.userToken()
//        return token.count > 0
    }
}
