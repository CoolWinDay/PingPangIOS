//
//  PP_ContentVideoCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/4.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ContentVideoCell: PP_ContentCell {

    @IBOutlet weak var videoView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        videoView.scrollView.bounces = false
        videoView.allowsInlineMediaPlayback = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
