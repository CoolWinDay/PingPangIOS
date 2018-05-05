//
//  PP_CommentCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/5.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_CommentCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var positionView: UILabel!
    @IBOutlet weak var commentView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellWithModel(_ model: PP_CommentModel?) {
        guard let model = model else { return }
        
        avatarView.kf.setImage(with: URL(string: model.icon))
        nameView.text = model.reply_name
        titleView.text = model.userTitle
        if let doubleDate = Double(model.posts_date) {
            let date = Date(timeIntervalSince1970: doubleDate/1000)
            dateView.text =  date.dateToString()
        }
        positionView.text = "\(model.position)楼"
        
        if model.reply_content.count > 0 {
            let content = model.reply_content[0]
            commentView.text = content.infor
        }
    }
    
}
