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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForumService.postList(boardId: boardId, topicId: topicId) { (topicDetail) in
            self.topicDetail = topicDetail
            self.buildView(topicDetail)
        }
    }
    
    func buildView(_ topicDetail: TopicDetailModel?) {
        guard let content = topicDetail?.content else { return }
        var subviews: [UIView] = []
        for model in content {
            switch model.type {
            case "0":
                let textView = UILabel()
                textView.numberOfLines = 0
                textView.text = model.infor
                subviews.append(textView)
                break
            case "1":
                let imageView = UIImageView()
                imageView.kf.setImage(with: URL(string: model.infor), completionHandler: { (image, error, cacheType, imageURL) in
                    if let image = imageView.image {
                        imageView.snp.makeConstraints({ (maker) in
                            maker.height.equalTo(imageView.snp.width).multipliedBy(image.size.height/image.size.width)
                        })
                    }
                })
                subviews.append(imageView)
                break
            case "2":
                if let url = URL(string: model.infor) {
                    let videoView = UIWebView()
                    videoView.scrollView.bounces = false
                    videoView.allowsInlineMediaPlayback = true
                    videoView.loadRequest(URLRequest(url: url))
                    videoView.snp.makeConstraints { (maker) in
                        maker.height.equalTo(videoView.snp.width).multipliedBy(0.57)
                    }
                    subviews.append(videoView)
                }
                break
            case "4":
                let textView = UILabel()
                textView.numberOfLines = 0
                textView.text = model.infor
                textView.textColor = UIColor.blue
                let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
                let underlineAttributedString = NSAttributedString(string: model.infor, attributes: underlineAttribute)
                textView.attributedText = underlineAttributedString
                textView.isUserInteractionEnabled = true
                textView.tapAction { (view) in
                    let webView = CMWebVC()
                    webView.webUrl = model.url
                    cmPushViewController(webView)
                }
                subviews.append(textView)
                break
            default:
                break
            }
        }
        
        var lastView: UIView!
        for (index, view) in subviews.enumerated() {
            self.scrollView.addSubview(view)
            view.snp.makeConstraints { (maker) in
                if index == 0 {
                    maker.top.equalToSuperview().offset(10)
                }
                else {
                    maker.top.equalTo(lastView.snp.bottom).offset(10)
                }
                
                if index == subviews.count-1 {
                    maker.bottom.equalToSuperview().offset(-10)
                }
                
                maker.left.equalToSuperview()
                maker.right.equalToSuperview()
                maker.width.equalToSuperview()
            }
            lastView = view
        }
    }
}
