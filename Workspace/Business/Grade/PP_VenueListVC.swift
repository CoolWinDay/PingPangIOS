//
//  PP_VenueListVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/25.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_VenueListVC: CMBaseVC {
    
    let CellRI = "PP_VenueListCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var venueList: [PP_VenueModel?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的俱乐部"

        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: CellRI, bundle: Bundle.main), forCellReuseIdentifier: CellRI)
        
        self.loadData()
    }
    
    func loadData() {
        PP_GradeService.myVenueList { (venueList) in
            if let list = venueList {
                self.venueList = list
                self.tableView.reloadData()
            }
        }
    }
}

extension PP_VenueListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellRI) as! PP_VenueListCell
        if let model = venueList[indexPath.row] {
            cell.cellWithData(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = venueList[indexPath.row] {
            cmPopViewController()
        }
    }
}
