//
//  DemoBusiness.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/9.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class DemoBusinessVC: CMBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    let arrayData = [("设置", "SettingVC"),
                     ("登录", "LoginVC"),
                     ("分享", "ShareVC"),
                     ("通知", "NotificationVC"),
                     ("位置", "LocationVC"),
                     ("Widget", "WidgetVC"),
                     ("二维码", "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.tableFooterView = UIView()
    }
    
    
    // MARK: - tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.selectionStyle = .none
        cell.textLabel?.text = arrayData[indexPath.row].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weak var weakSelf = self
        cmPushViewController(arrayData[indexPath.row].1) { (vc) in
            vc.title = weakSelf?.arrayData[indexPath.row].0
        }
    }
}
