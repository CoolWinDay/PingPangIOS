//
//  PP_TopicCellTableViewCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/4/29.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_TopicCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var sexView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subjectView: UILabel!
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var hitsView: UIButton!
    @IBOutlet weak var repliesView: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadWithModel(_ model: PP_TopicModel?) {
        if let model  = model {
            avatarView.kf.setImage(with: URL(string: model.userAvatar))
            
            switch model.gender {
            case "0" :
                sexView.image = nil
                break
            case "1" :
                sexView.image = UIImage(named: "dz_personal_icon_man")
                break
            case "2" :
                sexView.image = UIImage(named: "dz_personal_icon_woman")
                break
            default:
                break
            }
            
            if let doubleDate = Double(model.last_reply_date) {
                let date = Date(timeIntervalSince1970: doubleDate/1000)
                dateView.text =  date.dateToString()
            }
            nameView.text = model.user_nick_name
            titleView.text = model.title
            subjectView.text = model.subject
            
            if model.imageList.count > 0 {
                imageView0.kf.setImage(with: URL(string: model.imageList[0]))
            }
            if model.imageList.count > 1 {
                imageView1.kf.setImage(with: URL(string: model.imageList[1]))
            }
            if model.imageList.count > 2 {
                imageView2.kf.setImage(with: URL(string: model.imageList[2]))
            }
            
            hitsView.setTitle(model.hits, for: .normal)
            repliesView.setTitle(model.replies, for: .normal)
        }
    }
    
}
