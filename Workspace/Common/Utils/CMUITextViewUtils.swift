//
//  CMUILabelUtils.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/18.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

let cmTextViewAssociatedkey0 = UnsafeRawPointer.init(bitPattern: "cmTextViewAssociatedkey0".hashValue)
let cmTextViewAssociatedkey1 = UnsafeRawPointer.init(bitPattern: "cmTextViewAssociatedkey1".hashValue)
let cmUITextViewPlaceHolderTag = 10101

extension UITextView {
    
    func placeHolder(_ placeHolder: String, font: UIFont = UIFont.FontMid(), textColor: UIColor = UIColor.ColorTextNormal()) {
        let holderLabel = UILabel()
        holderLabel.tag = cmUITextViewPlaceHolderTag
        holderLabel.text = placeHolder
        holderLabel.font = font
        holderLabel.textColor = textColor
        self.addSubview(holderLabel)
        holderLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview().offset(5)
            maker.width.equalToSuperview()
            maker.height.equalTo(30)
        }
    }
    
    func maxTextNum(_ num: NSInteger) {
        objc_setAssociatedObject(self, cmTextViewAssociatedkey0, num, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewEditChanged(notification:)), name: .UITextViewTextDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing(notification:)), name: .UITextViewTextDidBeginEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing(notification:)), name: .UITextViewTextDidEndEditing, object: nil)
    }
    
    func disableEmoji() {
        objc_setAssociatedObject(self, cmTextViewAssociatedkey1, true, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func textViewEditChanged(notification: NSNotification) {
        if let disableEmoji = objc_getAssociatedObject(self, cmTextViewAssociatedkey1) as? Bool {
            if disableEmoji {
                let theString = self.text!
                if theString.isContainsEmoji() {
                    self.text = theString.stringWithoutEmoji()
                }
            }
        }
        
        if let num = objc_getAssociatedObject(self, cmTextViewAssociatedkey0) as? NSInteger {
            let range = self.markedTextRange
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
    
    func textViewDidBeginEditing(notification: NSNotification) {
        if let holderLabel = self.viewWithTag(cmUITextViewPlaceHolderTag) {
            holderLabel.isHidden = true
        }
    }
    
    func textViewDidEndEditing(notification: NSNotification) {
        if let holderLabel = self.viewWithTag(cmUITextViewPlaceHolderTag) {
            holderLabel.isHidden = self.text.characters.count > 0
        }
    }
    
    func subString2Index(_ index: NSInteger) {
        let toString = self.text!
        if toString.characters.count > index {
            self.text = toString.substring(to: toString.index(toString.startIndex, offsetBy: index))
        }
    }
}
