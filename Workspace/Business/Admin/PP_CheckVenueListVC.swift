//
//  PP_CheckListVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/7/9.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_CheckVenueListVC: CMBaseVC {
    
    let CellRI = "PP_VenueListCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segView: UISegmentedControl!
    
    var venueList: [PP_VenueModel?] = []
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "考场详情"
        
        self.tableView.register(UINib(nibName: CellRI, bundle: Bundle.main), forCellReuseIdentifier: CellRI)
        self.tableView.tableFooterView = UIView()
        
        self.loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: .kNFCheckedVenue, object: nil)
    }
    
    func loadData() {
        let index = segView.selectedSegmentIndex
        PP_GradeService.venueListWith(state: index) { (venueList) in
            if let list = venueList {
                self.venueList = list
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction
    func segChangeValue(sender: UISegmentedControl) {
        self.loadData()
    }
}

extension PP_CheckVenueListVC: UITableViewDataSource, UITableViewDelegate {
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
            let vc = PP_VenueDetailVC()
            vc.venueModel = model
            vc.isCheck = model.state == 0
            cmPushViewController(vc)
        }
    }
}
