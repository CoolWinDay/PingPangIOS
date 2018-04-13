//
//  ShareVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/4/27.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class ShareVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction
    func doShare() {
        CMShareManager.shareWith(title: "title", message: "message", thumImage: "https://mobile.umeng.com/images/pic/home/social/img-1.png", url: "https://mobile.umeng.com/images/pic/home/social/img-1.png")
    }

}
