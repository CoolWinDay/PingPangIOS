//
//  PP_ContentCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/5.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ContentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
