//
//  CMBaseViewController.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/23.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CMBaseVC: UIViewController {
    
    var rightItemAction = {}
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initVC()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initVC()
    }
    
    func initVC() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.navigationItem.leftBarButtonItem == nil {
            let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 49))
            backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            backButton.setTitleColor(UIColor.black, for: .normal)
            backButton.setImage(UIImage(named: "nav_back"), for: .normal)
            backButton.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            
            let backItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = backItem
        }
    }
    
    func showRightItem(title: String, action:  @escaping () -> Void) {
        rightItemAction = action
        let rightItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navgateRight))
        rightItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 17)], for: .normal)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func showRightItem(image: String, action: @escaping () -> Void) {
        rightItemAction = action
        let rightItem = UIBarButtonItem(image: UIImage(named: image), style: .plain, target: self, action: #selector(navgateRight))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func navigateBack() {
        self.navigationController!.popViewController(animated: true)
    }
    
    func navgateRight() {
        rightItemAction()
    }
}
