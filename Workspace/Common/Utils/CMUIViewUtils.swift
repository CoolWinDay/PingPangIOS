//
//  UIButtonAddition.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/23.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

let cmViewAssociatedkey = UnsafeRawPointer.init(bitPattern: "cmViewAssociatedkey".hashValue)

extension UIView {
    func tapAction(_ action:@escaping (UIView)->()) {
        objc_setAssociatedObject(self, cmViewAssociatedkey, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cmViewTaped)))
    }
    
    func cmViewTaped() {
        if let action = objc_getAssociatedObject(self, cmViewAssociatedkey) as? (UIView)->() {
            action(self)
        }
    }
}
