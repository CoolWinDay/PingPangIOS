//
//  TextVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/18.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class TextAndInputVC: CMBaseVC, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel.labelWith(text: "测试label ", textColor: UIColor.ColorTextDeep(), textAlignment: .center)
        label.backgroundColor = UIColor.orange
        self.view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.top.equalTo(40)
            maker.centerX.equalToSuperview()
            maker.size.equalTo(CGSize(width: 150, height: 50))
        }
        
        let textField = UITextField()
        textField.backgroundColor = UIColor.orange
        textField.placeholder = "placeholder"
        textField.delegate = self
        textField.maxTextNum(5)
        textField.disableEmoji()
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(-20)
            maker.centerX.equalToSuperview()
            maker.size.equalTo(CGSize(width: 150, height: 50))
        }
        
        let textView = UITextView()
        textView.backgroundColor = UIColor.orange
        textView.placeHolder("holder", font: UIFont.FontNormal(), textColor: UIColor.ColorTextWhite())
        textView.maxTextNum(8)
        textView.disableEmoji()
        self.view.addSubview(textView)
        textView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.size.equalTo(CGSize(width: 150, height: 150))
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }

}
