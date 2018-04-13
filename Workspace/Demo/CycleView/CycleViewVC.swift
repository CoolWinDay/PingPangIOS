//
//  CycleViewVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/30.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class CycleViewVC: CMBaseVC {
    
    let imagesUrl = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg", "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg", "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg", "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg" , "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg"]
    
    // 图片
    let images = [UIImage(named:"1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named:"5")]
    // 标题个数要和图片个数相同
    let titles = ["这是第1个页面", "这是第2个页面", "这是第3个页面", "这是第4个页面", "这是第5个页面"]
    var pptView1: PPTView!
    var pptView2: PPTView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果是从storyboard中加载的controller请设置这个属性为false
        automaticallyAdjustsScrollViewInsets = false
        
        // 添加第一个 带标题
        addPptView1()
        
        // 添加第二个 不带标题
        addPptView2()
    }

    
    func addPptView1()  {
        
        pptView1 = PPTView(imagesCount: { () -> Int in
            return self.images.count
        }, setupImageAndTitle: { (titleLabel, imageView, index) in
            imageView.image = self.images[index]
            titleLabel.text = self.titles[index]
            titleLabel.textColor = UIColor.red
        }) { (clickedIndex) in
            // 处理点击
            print(clickedIndex)
//            self.messageLabel.text = "点击了第\(clickedIndex)张图片"
        }
        
        pptView1.frame = CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 200)
        //设置pageController的颜色
        pptView1.pageIndicatorTintColor = UIColor.white
        pptView1.currentPageIndicatorTintColor = UIColor.brown
        pptView1.pageControlPosition = .topCenter
        // 滚动间隔, 默认三秒
        //        pptView.timerInterval = 2.0
        
        // 关闭自动滚动
        //        scrollImage.autoScorll = false
        view.addSubview(pptView1)
        /// 如果是网络获取到的信息, 获取完毕可以调用reloadData()重新加载页面
        //        pptView1.reloadData()
        
    }
    
    
    func addPptView2()  {
        
        pptView2 = PPTView.PPTViewWithImagesCount({ () -> Int in
            return self.images.count
        })
            .setupImageAndTitle({ (titleLabel, imageView, index) in
                imageView.image = self.images[index]
                titleLabel.text = self.titles[index]
                titleLabel.textColor = UIColor.red
            })
            .setupPageDidClickAction({ (clickedIndex) in
                // 处理点击
                print(clickedIndex)
//                self.messageLabel.text = "点击了第\(clickedIndex)张图片"
            })
        
        pptView2.frame = CGRect(x: 0, y: 310, width: view.bounds.size.width, height: 200)
        //设置pageController的颜色
        pptView2.pageIndicatorTintColor = UIColor.white
        pptView2.currentPageIndicatorTintColor = UIColor.brown
        pptView2.pageControlPosition = .bottomCenter
        // 滚动间隔, 默认三秒
        //        pptView.timerInterval = 2.0
        
        // 关闭自动滚动
        //        scrollImage.autoScorll = false
        view.addSubview(pptView2)
        
        /// 如果是网络获取到的信息, 获取完毕可以调用reloadData()重新加载页面
        //        pptView2.reloadData()
    }

}
