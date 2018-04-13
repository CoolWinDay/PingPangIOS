//
//  ImageCell.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/17.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellImageView.clipsToBounds = false
    }

}
