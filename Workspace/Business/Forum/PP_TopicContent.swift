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
    var cellHeightCache: [CGFloat] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    let cellRICell = "UITableViewCell"
    let cellRIText = "PP_ContentTextCell"
    let cellRIImage = "PP_ContentImageCell"
    let cellRIVideo = "PP_ContentVideoCell"
    let cellRILink = "PP_ContentLinkCell"
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellRICell)
        tableView.register(UINib(nibName: cellRIText, bundle: Bundle.main), forCellReuseIdentifier: cellRIText)
        tableView.register(UINib(nibName: cellRIImage, bundle: Bundle.main), forCellReuseIdentifier: cellRIImage)
        tableView.register(UINib(nibName: cellRIVideo, bundle: Bundle.main), forCellReuseIdentifier: cellRIVideo)
        tableView.register(UINib(nibName: cellRILink, bundle: Bundle.main), forCellReuseIdentifier: cellRILink)
        
        ForumService.postList(boardId: boardId, topicId: topicId) { (topicDetail) in
            self.topicDetail = topicDetail
            if let content = topicDetail?.content {
                for model in content {
                    if model.type == "2" {
                        self.cellHeightCache.append((UIScreen.ScreenWidth()-20)*0.57)
                    }
                    else {
                        self.cellHeightCache.append(UITableViewAutomaticDimension)
                    }
                }
            }
            
            self.tableView.reloadData()
        }
    }
}

extension PP_TopicContent: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let content = topicDetail?.content {
            return content.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightCache[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellRICell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isKind(of: PP_ContentImageCell.self) {
            (cell as! PP_ContentImageCell).imgView.kf.cancelDownloadTask()
        }
    }
}
