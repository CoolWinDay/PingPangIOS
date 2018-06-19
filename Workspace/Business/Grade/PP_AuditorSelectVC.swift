//
//  PP_AuditorSelectVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/19.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_AuditorSelectVC: CMBaseVC {
    
    let CellRI = "PP_AuditorListCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var venue_id = ""
    var dataList: [PP_AuditorModel?] = []
    var callBack: (PP_AuditorModel) -> () = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择考官"
        
        self.tableView.register(UINib(nibName: CellRI, bundle: Bundle.main), forCellReuseIdentifier: CellRI)
        self.tableView.tableFooterView = UIView()
        
        loadData()
    }
    
    func loadData() {
        PP_GradeService.auditorList(venueid: venue_id) { (auditorList) in
            if let list = auditorList {
                self.dataList = list
                self.tableView.reloadData()
            }
        }
    }
}

extension PP_AuditorSelectVC: UITableViewDataSource, UITableViewDelegate {
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
            callBack(model)
            cmPopViewController()
        }
    }
}
