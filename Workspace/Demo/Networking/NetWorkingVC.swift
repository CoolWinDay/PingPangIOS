//
//  NetWorkingVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/11.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class NetWorkingVC: CMBaseVC {
    
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var progress2: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction
    func request1(button: UIButton) {
        let request = BookRequest()
        request.responseModel = BookModel.self
        request.request().success { (response) in
            if let model = response as? BookModel {
                cmShowToast(model.alt)
            }
            cmShowToast(response.json?["alt"].string)
        }.failed { (response) in
            cmShowToast(response.error?.localizedDescription)
        }
    }
    
    @IBAction
    func request2(button: UIButton) {
        let request: CMRequest = CMRequest()
        request.url = "https://httpbin.org/get"
        request.method = .get
        request.request().success { (response) in
            cmShowToast(response.json?["headers"]["Host"].string)
        }.failed { (response) in
            cmShowToast(response.error?.localizedDescription)
        }
    }
    
    @IBAction
    func download(button: UIButton) {
        self.progress1.setProgress(0.0, animated: false)
        let totalSize = Int64(51779 * 1024)
        
        let request: CMRequest = CMRequest()
        request.url = "http://localhost:8080/CommonServer/servlet/validCodeImg"
        request.fileUrl = cmCacheUrl(name: "CommunityApp.ipa")
        request.parameters = ["test": "downLoad"]
        request.downLoad().success({ (response) in
            cmShowToast(response.fileUrl?.absoluteString)
            print(response.fileUrl!.absoluteString)
        }).failed { response in
            cmShowToast(response.error?.localizedDescription)
        }.progress { progress in
            let pro: Float = Float(progress.completedUnitCount)/Float(totalSize)
            self.progress1.setProgress(pro, animated: true)
            
            print("已下载：\(progress.completedUnitCount)KB")
            print("总大小：\(progress.totalUnitCount)KB")
            print("百分比：\(pro*100)%")
        }
    }
    
    @IBAction
    func upload(button: UIButton) {
        self.progress2.setProgress(0.0, animated: false)
        
        let filePath = Bundle.main.path(forResource: "CommunityApp", ofType: "ipa")
        if filePath == nil {
            cmShowToast("文件不存在")
            return
        }
        
        let request: CMRequest = CMRequest()
        request.url = "http://localhost:8080/CommonServer/servlet/validCodeImg"
        request.parameters = ["test": "1234"]
//        request.fileData = "测试".data(using: .utf8)
        request.fileData = FileManager.default.contents(atPath: filePath!)
        request.fileName = "CommunityApp.ipa"
//        request.fileData = UIImageJPEGRepresentation(UIImage(named: "LaunchImg3")!, 0.8)!
//        request.fileMimeType = "image/jpeg"
        request.upload().success { (response) in
            
        }.failed { (response) in
            cmShowToast(response.error?.localizedDescription)
        }.progress { (progress) in
            let pro = Float(progress.completedUnitCount)/Float(progress.totalUnitCount)
            
            self.progress2.setProgress(pro, animated: true)
            
            print("已上传：\(progress.completedUnitCount/1024)KB")
            print("总大小：\(progress.totalUnitCount/1024)KB")
            print("百分比：\(pro*100)%")
        }
    }
    
    @IBAction
    func checkNetState() {
        if CMNetWorkManager.isReachable() {
            if CMNetWorkManager.isReachableOnEthernetOrWiFi() {
                UIAlertView.alertWith(title: "wifi网络")
            }
            else if CMNetWorkManager.isReachableOnWWAN() {
                UIAlertView.alertWith(title: "蜂窝网络")
            }
        }
        else {
            UIAlertView.alertWith(title: "无网络")
        }
    }

}
