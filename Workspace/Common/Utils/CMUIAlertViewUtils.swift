//
//  UIButtonAddition.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/23.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

let cmAlertOKkey = UnsafeRawPointer.init(bitPattern: "cmAlertOKkey".hashValue)
let cmAlertCancelkey = UnsafeRawPointer.init(bitPattern: "cmAlertCanceldkey".hashValue)

extension UIAlertView: UIAlertViewDelegate {
    
    class func alertWith(title: String?, message: String = "", okButton: String = "确定", cancelButton: String? = "取消", okAction:@escaping (UIAlertView)->Void = {alert in }, cancelAction:@escaping (UIAlertView)->Void = {alert in }) {
        if let title = title {
            let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButton, otherButtonTitles: okButton)
            alertView.delegate = alertView
            objc_setAssociatedObject(alertView, cmAlertOKkey, okAction, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            objc_setAssociatedObject(alertView, cmAlertCancelkey, cancelAction, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            alertView.show()
        }
    }
    
    public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex {
            if let cancelAction = objc_getAssociatedObject(self, cmAlertCancelkey) as? (UIAlertView)->() {
                cancelAction(self)
            }
        }
        else {
            if let okAction = objc_getAssociatedObject(self, cmAlertOKkey) as? (UIAlertView)->() {
                okAction(self)
            }
        }
    }
    
}
