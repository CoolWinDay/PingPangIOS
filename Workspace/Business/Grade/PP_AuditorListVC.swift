//
//  PP_AuditorListVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/25.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_AuditorListVC: CMBaseVC {

    let CellRI = "PP_AuditorListCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [PP_AuditorModel?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的考官"
        
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: CellRI, bundle: Bundle.main), forCellReuseIdentifier: CellRI)
        
        self.loadData()
    }
    
    func loadData() {
//        PP_GradeService.myExamList { (list) in
//            let a = list?.count
//        }
        
        PP_GradeService.myAuditorList { (auditorList) in
            if let list = auditorList {
                self.dataList = list
                self.tableView.reloadData()
            }
        }
    }
}

extension PP_AuditorListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellRI) as! PP_AuditorListCell
        if let model = dataList[indexPath.row] {
            cell.cellWithData(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = dataList[indexPath.row] {
            cmPopViewController()
        }
    }
}
