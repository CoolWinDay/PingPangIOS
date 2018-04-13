//
//  UIButtonAddition.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/23.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

let cmButtonAssociatedkey = UnsafeRawPointer.init(bitPattern: "cmButtonAssociatedkey".hashValue)

extension UIButton {
    func addAction(for controlEvents: UIControlEvents,action:@escaping (UIButton)->()) {
        objc_setAssociatedObject(self, cmButtonAssociatedkey, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(cmButtonClick), for: controlEvents)
    }
    
    func addAction(_ action:@escaping (UIButton)->()) {
        objc_setAssociatedObject(self, cmButtonAssociatedkey, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(cmButtonClick), for: .touchUpInside)
    }
    
    func cmButtonClick() {
        if let action = objc_getAssociatedObject(self, cmButtonAssociatedkey) as? (UIButton)->() {
            action(self)
        }
    }
}
