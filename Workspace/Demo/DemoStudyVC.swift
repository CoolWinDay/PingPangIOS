//
//  DemoStudyVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/20.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import ESPullToRefresh

class DemoStudyVC: CMBaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    let arrayData = [("网络", "NetWorkingVC"),
                     ("图片", "ImageVC"),
                     ("segment", "SegmentVC"),
                     ("轮播图", "CycleViewVC"),
                     ("相册相机", "ImagePickerVC"),
                     ("文本和输入", "TextAndInputVC"),
                     ("字符串验证", "StringValidateVC")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.tableView.es.addPullToRefresh {
            sleep(2)
            self.tableView.es.stopPullToRefresh()
        }
        
        self.tableView.es.addInfiniteScrolling {
            sleep(2)
            self.tableView.es.stopLoadingMore()
            self.tableView.es.noticeNoMoreData()
        }
        
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
