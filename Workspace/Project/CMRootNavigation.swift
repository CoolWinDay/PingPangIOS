//
//  ComNavigationViewController.swift
//  CommonSwift
//
//  Created by lipeng on 16/9/7.
//  Copyright © 2016年 com.jsinda. All rights reserved.
//

import UIKit

class CMRootNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.ColorBgTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
