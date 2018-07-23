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
    
    @IBOutlet weak var venueStatistics: UILabel!
    @IBOutlet weak var auditorStatistics: UILabel!
    @IBOutlet weak var examStatistics: UILabel!

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
        
        PP_GradeService.statistics { (model) in
            if let model = model {
                self.venueStatistics.text = "总数：\(model.venueCountAll)，审核：\(model.venueCountChecked)，未审核：\(model.venueCountUncheck)"
                self.auditorStatistics.text = "总数：\(model.auditorCountAll)，审核：\(model.auditorCountChecked)，未审核：\(model.auditorCountUncheck)"
                self.examStatistics.text = "总数：\(model.examCountAll)，通过：\(model.examCountPassed)，未通过：\(model.examCountUnpass)，等待：\(model.examCountWaiting)"
            }
        }
        
    }

}
