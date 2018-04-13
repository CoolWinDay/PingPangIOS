//
//  TodayViewController.swift
//  WidgetDemo
//
//  Created by lipeng on 2017/5/9.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var udLabel: UILabel!
    @IBOutlet weak var fmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 共享数据
        self.udLabel.text = "UD数据:\(self.shareDataByUserDefaults())"
        self.fmLabel.text = "FM数据:\(self.shareDataByFileManager())"
        
        // 折叠
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        // 尺寸
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    //折叠change size
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        print("maxWidth %f maxHeight %f",maxSize.width,maxSize.height)
        
        if activeDisplayMode == NCWidgetDisplayMode.compact {
            self.preferredContentSize = CGSize(width:maxSize.width, height: 100);
        }
        else {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 200);
        }
    }
    
    @IBAction
    func openButtonPressed() {
        let url : URL = URL.init(string: "cmWidgetDemo://HelloWorld")!
        self.extensionContext?.open(url, completionHandler: {(isSucces) in
            print("点击了红色按钮，来唤醒APP，是否成功 : \(isSucces)")
        })
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    
    func shareDataByUserDefaults() -> String {
        let userDefaults = UserDefaults(suiteName: "group.com.sinooceanland.yjq")
        let object = userDefaults?.value(forKey: "widget")
        if let string = object as? String {
            return string
        }
        return ""
    }
    
    // FileManager方式共享数据
    func shareDataByFileManager() -> String {
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.sinooceanland.yjq")
        url = url?.appendingPathComponent("Library/Caches/widget", isDirectory: true)
        var str = ""
        
        do {
            str =  try String.init(contentsOf: url!, encoding: String.Encoding.utf8)
        } catch let error {
            print(error)
        }
        
        return str
        
    }
    
}
