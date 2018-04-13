//
//  WidgetVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/5/13.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class WidgetVC: CMBaseVC {
    
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction
    func shareWithUserDefaults() {
        let text = self.textField.text?.trimSpace();
        
        let userDefaults = UserDefaults(suiteName: "group.com.sinooceanland.yjq")
        userDefaults?.set(text, forKey: "widget")
        userDefaults?.synchronize()
    }
    
    @IBAction
    func shareWithFileManager() {
        let text = self.textField.text?.trimSpace();
        
        var url : URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.sinooceanland.yjq")!
        url = url.appendingPathComponent("Library/Caches/widget", isDirectory: true)

        do{
            _ = try text?.write(to: url, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print(error)
        }
    }

}
