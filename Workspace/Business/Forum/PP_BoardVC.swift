//
//  PP_BoardVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/4/13.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_BoardVC: CMBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "UITableViewCell"
    
    var boardList: [PP_BoardModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
}

extension PP_BoardVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
        let model = boardList[indexPath.row]
        cell?.textLabel?.text = model.board_name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PP_TopicVC()
        let model = boardList[indexPath.row]
        vc.title = model.board_name
        vc.board_id = model.board_id
        cmPushViewController(vc)
    }
}
