//
//  StringValidateVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/19.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class StringValidateVC: CMBaseVC {
    
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 验证数字
    @IBAction
    func validate0() {
        let text = textField.text!
        let isValidate = text.isNumber()
        self.showResult(isValidate)
    }
    
    @IBAction
    func validate1() {
        let text = textField.text!
        let isValidate = text.isLetter()
        self.showResult(isValidate)
    }
    
    @IBAction
    func validate2() {
        let text = textField.text!
        let isValidate = text.isChiness()
        self.showResult(isValidate)
    }
    
    @IBAction
    func validate3() {
        let text = textField.text!
        let isValidate = text.isContainsEmoji()
        self.showResult(isValidate)
    }
    
    @IBAction
    func validate4() {
        let text = textField.text!
        let isValidate = text.isPhoneNumber()
        self.showResult(isValidate)
    }
    
    @IBAction
    func validate5() {
        let text = textField.text!
        let isValidate = text.isIdentityCard()
        self.showResult(isValidate)
    }
    
    @IBAction
    func validate6() {
        let text = textField.text!
        let isValidate = text.isEmail()
        self.showResult(isValidate)
    }
    
    func showResult(_ isValidate: Bool) {
        cmShowToast(isValidate ? "✅" : "❌", position: .top)
    }
    
}
