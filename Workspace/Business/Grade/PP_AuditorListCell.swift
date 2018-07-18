//
//  PP_AuditorListCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/19.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import Kingfisher

class PP_AuditorListCell: UITableViewCell {

    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var introduceView: UILabel!
    
    func cellWithData(_ model: PP_AuditorModel) {
        self.nameView.text = model.name
        self.introduceView.text = model.introduce
        self.picView.image = UIImage(named: "img_empty")
        
        if let avatarImage = model.avatarImage {
            let imageUrl = avatarImage.imageUrl
            if let url = URL(string: imageUrl) {
                picView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1)), .keepCurrentImageWhileLoading])
            }
        }
    }
    
}
