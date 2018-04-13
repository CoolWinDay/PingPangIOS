//
//  CMUILabelUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/18.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

extension UILabel {
    class func labelWith(text: String = "", font: UIFont = UIFont.FontNormal(), textColor: UIColor = UIColor.ColorTextNormal(), textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        return label;
    }
}
