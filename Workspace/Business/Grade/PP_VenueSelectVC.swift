//
//  PP_VenueSelectVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/18.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_VenueSelectVC: CMBaseVC {
    
    let CellRI = "PP_VenueListCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cityView: UITextField!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var locationView: ChooseLocationView!
    
    var address = ""
    var venueList: [PP_VenueModel?] = []
    var callBack: (PP_VenueModel) -> () = {_ in}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择考场"
        
        self.tableView.register(UINib(nibName: CellRI, bundle: Bundle.main), forCellReuseIdentifier: CellRI)
        self.tableView.tableFooterView = UIView()
        
        self.cityView.text = address
        
        cityView.tapAction { (view) in
            self.coverView.isHidden = false
            self.locationView.isHidden = false
            self.isEditing = false
        }
        
        locationView.chooseCancel = {
            self.coverView.isHidden = true
            self.locationView.isHidden = true
        }
        
        locationView.chooseFinish = {
            self.coverView.isHidden = true
            self.locationView.isHidden = true
            self.cityView.text = self.locationView.address
            self.loadData()
        }
        
        loadData()
    }

    func loadData() {
        guard let address = self.cityView.text, address.count > 0 else { return }
        
        var province = ""
        var city = ""
        var county = ""
        
        let substrings = address.split(separator: ",")
        if substrings.count > 0 {
            province = String(substrings[0])
        }
        if substrings.count > 1 {
            city = String(substrings[1])
        }
        if substrings.count > 1 {
            county = String(substrings[2])
        }
        
        PP_GradeService.venueList(province: province, city: city, county: county) { (venueList) in
            if let list = venueList {
                self.venueList = list
                self.tableView.reloadData()
            }
        }
    }
}

extension PP_VenueSelectVC: UITableViewDataSource, UITableViewDelegate {
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
            callBack(model)
            cmPopViewController()
        }
    }
}
