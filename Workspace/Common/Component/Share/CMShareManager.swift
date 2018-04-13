//
//  CMShareManager.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/28.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CMShareManager: NSObject {
    
    var shareTitle: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    var shareDescr = ""
    var shareThumImage: Any = UIImage(named: "ShareDefault") as Any
    var shareUrl = "http://mobile.umeng.com/social"
    
    // 单例
    static let sharedInstance = CMShareManager()
    override private init() {
        super.init()
    }
    
    func shareWebPage(platformType: UMSocialPlatformType) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareWebpageObject.shareObject(withTitle: shareTitle, descr: shareDescr, thumImage: shareThumImage)
        shareObject?.webpageUrl = shareUrl
        messageObject.shareObject = shareObject
        messageObject.text = shareUrl
        
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: cmTopMostViewController()) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func shareImage(platformType: UMSocialPlatformType) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareImageObject.shareObject(withTitle: shareTitle, descr: shareDescr, thumImage: shareThumImage)
        shareObject?.shareImage = shareThumImage
        messageObject.shareObject = shareObject
        messageObject.text = "\(shareUrl) \(shareDescr)"
        
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: cmTopMostViewController()) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    class func shareWith(title: String = CMShareManager.sharedInstance.shareTitle, message: String = CMShareManager.sharedInstance.shareDescr, thumImage: Any? = CMShareManager.sharedInstance.shareThumImage, url: String = CMShareManager.sharedInstance.shareUrl) {
        let manager = CMShareManager.sharedInstance
        manager.shareTitle = title
        manager.shareDescr = message
        if let thumImage = thumImage {
            manager.shareThumImage = thumImage
        }
        manager.shareUrl = url

        UMSocialUIManager.setPreDefinePlatforms([UMSocialPlatformType.wechatSession.rawValue, UMSocialPlatformType.wechatTimeLine.rawValue, UMSocialPlatformType.sina.rawValue, UMSocialPlatformType.QQ.rawValue, UMSocialPlatformType.qzone.rawValue])
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            switch platformType {
            case .sina:
                manager.shareImage(platformType: platformType)
            default:
                manager.shareWebPage(platformType: platformType)
            }
        }
    }
}
