//
//  PP_TopicContent.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/5/1.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_TopicContent: CMBaseVC {
    
    var boardId: String = ""
    var topicId: String = ""
    var topicDetail: TopicDetailModel?
    var commentList: [PP_CommentModel?] = []
    var cellHeightCache: [CGFloat] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    // header
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var hitsView: UIButton!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var sexView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    
    let cellRICell = "UITableViewCell"
    let cellRIText = "PP_ContentTextCell"
    let cellRIImage = "PP_ContentImageCell"
    let cellRIVideo = "PP_ContentVideoCell"
    let cellRILink = "PP_ContentLinkCell"
    let cellRIComment = "PP_CommentCell"
    
    var page = 1
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellRICell)
        tableView.register(UINib(nibName: cellRIText, bundle: Bundle.main), forCellReuseIdentifier: cellRIText)
        tableView.register(UINib(nibName: cellRIImage, bundle: Bundle.main), forCellReuseIdentifier: cellRIImage)
        tableView.register(UINib(nibName: cellRIVideo, bundle: Bundle.main), forCellReuseIdentifier: cellRIVideo)
        tableView.register(UINib(nibName: cellRILink, bundle: Bundle.main), forCellReuseIdentifier: cellRILink)
        
        tableView.register(UINib(nibName: cellRIComment, bundle: Bundle.main), forCellReuseIdentifier: cellRIComment)
        
        tableView.tableHeaderView = self.headerView
        
        
        self.tableView.es.addPullToRefresh {
            self.page = 1
            self.commentList.removeAll()
            self.loadData()
        }
        
        self.tableView.es.addInfiniteScrolling {
            self.page += 1
            self.loadData()
        }
        
        loadData()
    }
    
    func loadData() {
        ForumService.postList(boardId: boardId, topicId: topicId, page: page) { (topicDetail, commentList) in
            if self.page == 1 {
                self.tableView.es.stopPullToRefresh()
            }
            else {
                self.tableView.es.stopLoadingMore()
                if let list = commentList, list.count >= 10 {
                } else {
                    self.tableView.es.noticeNoMoreData()
                }
            }
            
            if self.page == 1 {
                self.topicDetail = topicDetail
            }
            
            let lastIndex = self.commentList.count
            var newCount = 0
            if let commentList = commentList {
                newCount = commentList.count
                self.commentList.append(contentsOf: commentList)
            }
            
            self.initHeaderView(topicDetail)
            if let content = topicDetail?.content {
                for model in content {
                    if model.type == "2" {
                        self.cellHeightCache.append((UIScreen.ScreenWidth()-20)*0.57+10)
                    }
                    else {
                        self.cellHeightCache.append(UITableViewAutomaticDimension)
                    }
                }
            }
            
            if self.page == 1 {
                self.tableView.reloadData()
            }
            else if newCount > 0 {
                var indexPaths: [IndexPath] = []
                for index in 0...newCount-1 {
                    indexPaths.append(IndexPath(row: lastIndex+index, section: 1))
                }
                self.tableView.insertRows(at: indexPaths, with: .none)
            }
        }
    }
    
    func initHeaderView(_ topicDetail: TopicDetailModel?) {
        if let model  = topicDetail {
            titleView.text = model.title
            hitsView.setTitle(model.hits, for: .normal)
            
            avatarView.kf.setImage(with: URL(string: model.icon))
            nameView.text = model.user_nick_name
            switch model.gender {
            case "0" :
                sexView.image = nil
                break
            case "1" :
                sexView.image = UIImage(named: "dz_personal_icon_man")
                break
            case "2" :
                sexView.image = UIImage(named: "dz_personal_icon_woman")
                break
            default:
                break
            }
            if let doubleDate = Double(model.create_date) {
                let date = Date(timeIntervalSince1970: doubleDate/1000)
                dateView.text =  date.dateToString()
            }
        }
    }
}

extension PP_TopicContent: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let content = topicDetail?.content {
                return content.count
            }
        }
        else if section == 1 {
            return commentList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return cellHeightCache[indexPath.row]
        }
        else if indexPath.section == 1 {
            return UITableViewAutomaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let model = topicDetail?.content[indexPath.row] {
                switch model.type {
                case "0":
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellRIText) as! PP_ContentTextCell
                    cell.textView.text = model.infor
                    return cell
                case "1":
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellRIImage) as! PP_ContentImageCell
                    cell.imgView.kf.setImage(with: URL(string: model.infor), completionHandler: { (image, error, cacheType, imageURL) in
                        if let image = cell.imgView.image {
                            if self.cellHeightCache[indexPath.row] == UITableViewAutomaticDimension {
                                let imageHeight = cell.imgView.bounds.width*image.size.height/image.size.width
                                self.cellHeightCache[indexPath.row] = imageHeight
                                tableView.reloadRows(at: [indexPath], with: .none)
                            }
                        }
                    })
                    return cell
                case "2":
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellRIVideo) as! PP_ContentVideoCell
                    if let url = URL(string: model.infor) {
                        cell.videoView.loadRequest(URLRequest(url: url))
                    }
                    return cell
                case "4":
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellRILink) as! PP_ContentLinkCell
                    cell.linkView.text = model.infor
                    let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
                    let underlineAttributedString = NSAttributedString(string: model.infor, attributes: underlineAttribute)
                    cell.linkView.attributedText = underlineAttributedString
                    cell.linkView.tapAction { (view) in
                        let webView = CMWebVC()
                        webView.webUrl = model.url
                        cmPushViewController(webView)
                    }
                    return cell
                default:
                    break
                }
            }
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRIComment) as! PP_CommentCell
            cell.selectionStyle = .none
            if let comment = commentList[indexPath.row] {
                cell.cellWithModel(comment)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellRICell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isKind(of: PP_ContentImageCell.self) {
            (cell as! PP_ContentImageCell).imgView.kf.cancelDownloadTask()
        }
    }
}
