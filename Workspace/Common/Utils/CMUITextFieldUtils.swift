//
//  CMUILabelUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/18.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

let cmTextFieldAssociatedkey0 = UnsafeRawPointer.init(bitPattern: "cmTextFieldAssociatedkey0".hashValue)
let cmTextFieldAssociatedkey1 = UnsafeRawPointer.init(bitPattern: "cmTextFieldAssociatedkey1".hashValue)

extension UITextField {
    
    func maxTextNum(_ num: NSInteger) {
        self.addTarget(self, action: #selector(textFiledEditChanged(textField:)), for: UIControlEvents.editingChanged);
        objc_setAssociatedObject(self, cmTextFieldAssociatedkey0, num, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func disableEmoji() {
        objc_setAssociatedObject(self, cmTextFieldAssociatedkey1, true, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func textFiledEditChanged(textField: UITextField) {
        if let disableEmoji = objc_getAssociatedObject(self, cmTextFieldAssociatedkey1) as? Bool {
            if disableEmoji {
                let theString = self.text!
                if theString.isContainsEmoji() {
                    self.text = theString.stringWithoutEmoji()
                }
            }
        }
        
        
        if let num = objc_getAssociatedObject(self, cmTextFieldAssociatedkey0) as? NSInteger {
            let range = textField.markedTextRange
            if let range = range {
                if range.isEmpty {
                    subString2Index(num)
                }
            }
            else {
                subString2Index(num)
            }
        }
    }
    
    func subString2Index(_ index: NSInteger) {
        let toString = self.text!
        if toString.characters.count > index {
            self.text = toString.substring(to: toString.index(toString.startIndex, offsetBy: index))
        }
    }
}
