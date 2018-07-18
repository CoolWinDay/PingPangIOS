//
//  PP_ExamListCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/25.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import Kingfisher

class PP_ExamListCell: UITableViewCell {
    
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var venueView: UILabel!
    @IBOutlet weak var auditorView: UILabel!
    @IBOutlet weak var gradeView: UILabel!
    
    func cellWithData(_ model: PP_ExamModel) {
        self.nameView.text = model.examinee?.name
        self.venueView.text = model.venue?.name
        self.auditorView.text = model.auditor?.name
        self.gradeView.text = model.exam_grade
        self.picView.image = UIImage(named: "img_empty")
        
        if let examinee = model.examinee {
            if let avatarImage = examinee.avatarImage {
                if let url = URL(string: avatarImage.imageUrl) {
                    self.picView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1)), .keepCurrentImageWhileLoading])
                }
            }
        }
    }
    
}
