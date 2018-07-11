//
//  PP_AdminVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/7/9.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_AdminVC: CMBaseVC {
    
    @IBOutlet weak var venueView: UIView!
    @IBOutlet weak var auditorView: UIView!
    @IBOutlet weak var examView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "管理员"
        
        venueView.tapAction { (view) in
            cmPushViewController("PP_CheckVenueListVC")
        }
        
        auditorView.tapAction { (view) in
            cmPushViewController("PP_CheckAuditorListVC")
        }
        
        examView.tapAction { (view) in
            cmPushViewController("PP_CheckExamListVC")
        }
        
    }

}
