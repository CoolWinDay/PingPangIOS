//
//  PP_VenueListCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/19.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import Kingfisher

class PP_VenueListCell: UITableViewCell {
    
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var introduceView: UILabel!

    func cellWithData(_ model: PP_VenueModel) {
        self.nameView.text = model.name
        self.introduceView.text = model.introduce
        self.picView.image = UIImage(named: "img_empty")
        
        if model.venueImage.count > 0 {
            let imageUrl = model.venueImage[0].imageUrl
            if let url = URL(string: imageUrl) {
                picView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1)), .keepCurrentImageWhileLoading])
            }
        }
    }
    
}
