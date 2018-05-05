//
//  PP_ForumVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/4/13.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ForumVC: CMBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "UITableViewCell"
    
    var forumList: [PP_ForumModel?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        ForumService.forumList { (forumList) in
            self.forumList = forumList
            self.tableView.reloadData()
        }
    }

}

extension PP_ForumVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
        let model = forumList[indexPath.row]
        cell?.textLabel?.text = model?.board_category_name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PP_BoardVC()
        if let model = forumList[indexPath.row] {
            vc.boardList = model.board_list
        }
        cmPushViewController(vc)
    }
}
