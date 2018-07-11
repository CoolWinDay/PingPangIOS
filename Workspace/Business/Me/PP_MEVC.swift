//
//  PP_MEVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/23.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_MEVC: CMBaseVC {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var loginView: UIButton!
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var avartaView: UIImageView!
    
    @IBOutlet weak var gradeView: UIView!
    @IBOutlet weak var auditorView: UIView!
    @IBOutlet weak var venueView: UIView!
    @IBOutlet weak var adminView: UIView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: .NotificationUserLogin, object: nil)
        
        refreshView()
        
        gradeView.tapAction { (view) in
            cmPushViewController("PP_ExamListVC")
        }
        
        auditorView.tapAction { (view) in
            cmPushViewController("PP_AuditorListVC")
        }
        
        venueView.tapAction { (view) in
            cmPushViewController("PP_VenueListVC")
        }
        
        adminView.tapAction { (view) in
            cmPushViewController("PP_AdminVC")
        }
    }
    
    func refreshView() {
        let model = PP_UserModel.modelWithCache()
        
        if let model = model {
            self.infoView.isHidden = false
            self.loginView.isHidden = true
            self.nameView.text = model.userName
            self.titleView.text = model.userTitle
            self.avartaView.kf.setImage(with: URL(string: model.avatar))
            
            let isAdmin = model.isAdminUser()
            self.adminView.isHidden = !isAdmin
            
        }
        else {
            self.infoView.isHidden = true
            self.loginView.isHidden = false
            self.nameView.text = ""
            self.titleView.text = ""
            self.avartaView.image = UIImage(named: "head_def")
        }
    }
    
    @IBAction
    func doLogin() {
        cmShowLogin(animated: true)
    }
    
    @IBAction
    func doLogout() {
        PP_UserModel.removeLoginCache()
        refreshView()
        cmShowToast("已退出登录")
        NotificationCenter.default.post(name: .NotificationUserLogout, object: nil)
    }

}
