//
//  ImagePickerVC.swift
//  CommonSwift
//
//  Created by Lilefan on 2017/4/11.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class ImagePickerVC: CMBaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var albumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        self.showRightItem(title: "拍照") {
            weakSelf?.presentImagePickerVC(.camera)
        }
        
        self.albumButton.addAction { (button) in
            weakSelf?.presentImagePickerVC(.photoLibrary)
        }
    }

    func presentImagePickerVC(_ type: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            
            var isRight = false
            if type == .camera && isRightCamera() {
                isRight = true
            } else if type == .photoLibrary && isRightPhoto() {
                isRight = true
            }
            
            if isRight {
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                var noticeStr:String = ""
                if type == .camera {
                    noticeStr = "请开启相机权限"
                } else if type == .photoLibrary {
                    noticeStr = "请开启相册权限"
                }

                UIAlertView.alertWith(title: noticeStr, okButton: "去设置", okAction: { (alertView) in
                    goSettings()
                })
            }
        } else {
            UIAlertView.alertWith(title: "不支持相机", okAction: { (alert) in
                
            })
        }
    }
    
    //MARK: - imagePickerController delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let type:String = info[UIImagePickerControllerMediaType] as! String
        if type == "public.image" {
            let img = info[UIImagePickerControllerOriginalImage] as? UIImage // 默认图片
            let fixedImg = img?.fixOrientation() // 修复自动旋转90度的问题
            self.imageView.image = fixedImg
            picker.dismiss(animated:true, completion:nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit...")
    }
}
