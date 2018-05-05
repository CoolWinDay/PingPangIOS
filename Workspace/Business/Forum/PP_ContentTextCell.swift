//
//  PP_ContentTextCell.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/4.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ContentTextCell: PP_ContentCell {
    
    @IBOutlet weak var textView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        //通过富文本来设置行间距
//        let paraph = NSMutableParagraphStyle()
//        //将行间距设置为28
//        paraph.lineSpacing = 20
//        //样式属性集合
//        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 15),
//                          NSParagraphStyleAttributeName: paraph]
//        textView.attributedText = NSAttributedString(string: str, attributes: attributes)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
