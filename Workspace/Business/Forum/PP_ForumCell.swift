//
//  PP_ForumCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/6.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ForumCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var numView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cellWithModel(_ model: PP_BoardModel?) {
        if let model = model {
            imgView.kf.setImage(with: URL(string: model.board_img))
            nameView.text = model.board_name
            if let doubleDate = Double(model.last_posts_date) {
                let date = Date(timeIntervalSince1970: doubleDate/1000)
                dateView.text =  date.dateToString()
            }
            numView.text = "(\(model.td_posts_num))"
        }
        else {
            imgView.image = nil
            nameView.text = ""
            dateView.text = ""
            numView.text = ""
        }
    }
}
