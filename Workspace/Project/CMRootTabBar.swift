//
//  CMTabBarController.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/9.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CMRootTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.ColorBgTheme()
        self.delegate = self;
        
        let vc0 = DemoHomeVC()
        vc0.tabBarItem.image = UIImage(named: "tab_home")
        vc0.tabBarItem.title = "首页"
        
        let vc3 = DemoStudyVC()
        vc3.tabBarItem.image = UIImage(named: "tab_shopping")
        vc3.tabBarItem.title = "学习"
        
        let vc1 = DemoBusinessVC()
        vc1.tabBarItem.image = UIImage(named: "tab_shopping")
        vc1.tabBarItem.title = "功能"
        
        let vc2 = DemoMeVC()
        vc2.tabBarItem.image = UIImage(named: "tab_me")
        vc2.tabBarItem.title = "我的"
        
        self.viewControllers = [vc0, vc3, vc1, vc2]
        self.title = vc0.tabBarItem.title
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.title = item.title;
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isHome = viewController.isMember(of: DemoHomeVC.self)
        self.navigationController?.setNavigationBarHidden(isHome, animated: false)
        return true
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
