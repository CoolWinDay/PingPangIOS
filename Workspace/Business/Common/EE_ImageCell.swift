//
//  EE_CheckDetailCell.swift
//  EyeExamine
//
//  Created by LpSun on 2018/1/9.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class EE_ImageCell: UICollectionViewCell {
    
    typealias DelBlock = () -> ()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonView: UIButton!
    
    var delBlock: DelBlock = {_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func enableDelete(_ enable: Bool) {
        buttonView.isHidden = !enable
        buttonView.isUserInteractionEnabled = enable
    }
    
    @IBAction
    func delPic() {
        delBlock()
    }
}
