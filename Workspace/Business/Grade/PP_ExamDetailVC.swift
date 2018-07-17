//
//  PP_ExamApplyVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/19.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import TZImagePickerController
import MWPhotoBrowser

class PP_ExamDetailVC: CMBaseVC {
    
    var examModel: PP_ExamModel?
    var isCheck: Bool = false

    let cellIdentifier0 = "EE_ImageCell"
    let cellIdentifier1 = "EE_AddCell"
    let headerIdentifier = "UICollectionReusableView"
    let numberOfLine: CGFloat = 3.0
    let cellPadding: CGFloat = 15.0
    let maxImageCount = 6
    
    @IBOutlet weak var avatarView: UIButton!
    @IBOutlet weak var nameView: UITextField!
    @IBOutlet weak var ageView: UITextField!
    @IBOutlet weak var phoneView: UITextField!
    @IBOutlet weak var idcardView: UITextField!
    @IBOutlet weak var venueView: UITextField!
    @IBOutlet weak var auditorView: UITextField!
    @IBOutlet weak var timeView: UITextField!
    @IBOutlet weak var gradeView: UITextField!
    @IBOutlet weak var sexView: UITextField!
    @IBOutlet weak var checkView: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var headView: UIView!
    @IBOutlet weak var submitView: UIButton!
    
    var venue_id = ""
    var auditor_id = ""
    let gradePickerData = ["预备级", "一级", "二级", "三级", "四级", "五级", "六级", "七级", "八级", "九级"]
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "考级详情"
        
        collectionView.register(UINib(nibName: cellIdentifier0, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier0)
        collectionView.register(UINib(nibName: cellIdentifier1, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier1)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        if let model = examModel {
            if let examinee = model.examinee {
                self.nameView.text = examinee.name
                self.ageView.text = examinee.age
                self.phoneView.text = examinee.phone
                self.idcardView.text = examinee.idcard
                self.sexView.text = examinee.sex
                if let avatarImage = examinee.avatarImage {
                    self.avatarView?.kf.setImage(with: URL(string: avatarImage.imageUrl), for: .normal)
                }
            }
            if let venue = model.venue {
                self.venueView.text = venue.name
            }
            if let auditor = model.auditor {
                self.auditorView.text = auditor.name
            }
            
            self.timeView.text = model.exam_time
            if let intGrade = Int(model.exam_grade), gradePickerData.count > intGrade {
                self.gradeView.text = gradePickerData[intGrade]
            }
        }
        
        if isCheck {
            submitView.setTitle("通过审核", for: .normal)
        }
        else {
            submitView.isUserInteractionEnabled = false
            submitView.backgroundColor = UIColor.ColorBgGray()
        }
    }
    
    @IBAction
    func toAgreement() {
        let webVC = CMWebVC()
        webVC.title = "考生网上报名协议"
        webVC.webUrl = "https://www.baidu.com"
        cmPushViewController(webVC)
    }
    
    @IBAction
    func doSubmit() {
        guard let model = examModel else {
            cmShowToast("数据错误")
            return
        }
        
        PP_GradeService.checkExam(kid: model.kid) { (isSuccess) in
            if isSuccess {
                NotificationCenter.default.post(name: .kNFCheckedExam, object: nil)
                cmShowToast("审核成功")
                cmPopViewController()
            }
            else {
                cmShowToast("审核失败")
            }
        }
    }
}

extension PP_ExamDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if (indexPath.row == imageArray.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier1, for: indexPath) as! EE_AddCell
            return cell
//        }
//        else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier0, for: indexPath) as! EE_ImageCell
//            cell.imageView.image = self.imageArray[indexPath.row]
//            cell.enableDelete(true)
//            cell.delBlock = {
//                self.imageArray.remove(at: indexPath.row)
//                collectionView.reloadData()
//            }
//            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = floor((collectionView.bounds.width - 20*2 - (numberOfLine-1)*cellPadding) / numberOfLine)
        return CGSize(width: cellWidth, height: cellWidth*0.81)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(cellPadding, 20, cellPadding, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 480)
    }
    
    // header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath)
            if !headerView.subviews.contains(self.headView) {
                headerView.addSubview(headView)
                headView.snp.makeConstraints({ (make) in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                })
            }
            return headerView
        }
        return UICollectionReusableView()
    }
}
