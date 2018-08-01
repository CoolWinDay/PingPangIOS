//
//  PP_HomeVenueCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/7/31.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import Kingfisher

class PP_HomeAuditorCell: UICollectionViewCell {

    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var countView: UILabel!
    @IBOutlet weak var venueView: UILabel!
    @IBOutlet weak var orderView: UILabel!
    
    func cellWithData(_ model: PP_AuditorModel) {
        self.nameView.text = model.name
        self.countView.text = model.examcount
        self.venueView.text = model.venue?.name
        self.picView.image = UIImage(named: "img_empty")
        
        if let avatarImage = model.avatarImage {
            let imageUrl = avatarImage.imageUrl
            if let url = URL(string: imageUrl) {
                picView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1)), .keepCurrentImageWhileLoading])
            }
        }
    }
}
