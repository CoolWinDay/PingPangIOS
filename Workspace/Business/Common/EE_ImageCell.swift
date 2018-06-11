//
//  EE_CheckDetailCell.swift
//  EyeExamine
//
//  Created by LpSun on 2018/1/9.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class EE_ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func selectPic(_ isSelected: Bool) {
        buttonView.isSelected = isSelected
    }

    func isPicSelected() -> Bool {
        return buttonView.isSelected
    }
    
    func enableSelect(_ enable: Bool) {
        buttonView.isHidden = !enable
        buttonView.isUserInteractionEnabled = enable
    }
    
    
}
