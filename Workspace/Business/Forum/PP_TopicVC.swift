//
//  PP_TopicVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/4/13.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import Kingfisher

class PP_TopicVC: CMBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellRICell = "PP_TopicCell"
    let cellRICell2 = "PP_TopicCell2"
    
    var board_id: String = ""
    var topicList: [PP_TopicModel?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellRICell, bundle: Bundle.main), forCellReuseIdentifier: cellRICell)
        tableView.register(UINib(nibName: cellRICell2, bundle: Bundle.main), forCellReuseIdentifier: cellRICell2)
        tableView.tableFooterView = UIView()
        
        ForumService.topicListEx(boardId: board_id) { (topicList) in
            self.topicList = topicList
            self.tableView.reloadData()
        }
    }
}

extension PP_TopicVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = topicList[indexPath.row]!
        if model.imageList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRICell) as! PP_TopicCell
            cell.selectionStyle = .none
            cell.loadWithModel(model)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRICell2) as! PP_TopicCell2
            cell.selectionStyle = .none
            cell.loadWithModel(model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = topicList[indexPath.row] {
            let vc = PP_TopicContent()
            vc.title = self.title
            vc.boardId = self.board_id
            vc.topicId = model.topic_id
            cmPushViewController(vc)
        }
    }
}
