//
//  PP_CheckAuditorListVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/7/9.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_CheckAuditorListVC: CMBaseVC {
    
    let CellRI = "PP_AuditorListCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segView: UISegmentedControl!

    var dataList: [PP_AuditorModel?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "审核考官"
        
        self.tableView.register(UINib(nibName: CellRI, bundle: Bundle.main), forCellReuseIdentifier: CellRI)
        self.tableView.tableFooterView = UIView()
        
        self.loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: .kNFCheckedAuditor, object: nil)
    }
    
    func loadData() {
        let index = segView.selectedSegmentIndex
        PP_GradeService.auditorListWith(state: index) { (auditorList) in
            if let list = auditorList {
                self.dataList = list
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction
    func segChangeValue(sender: UISegmentedControl) {
        self.loadData()
    }
}

extension PP_CheckAuditorListVC: UITableViewDataSource, UITableViewDelegate {
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
            let vc = PP_AuditorDetailVC()
            vc.auditorModel = model
            vc.isCheck = model.state == 0
            cmPushViewController(vc)
        }
    }
}
