//
//  PP_GradeVenueApplyVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/10.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import TZImagePickerController
import MWPhotoBrowser

class PP_VenueDetailVC: CMBaseVC {
    
    var venueModel: PP_VenueModel?
    var isCheck: Bool = false
    
    let cellIdentifier0 = "EE_ImageCell"
    let cellIdentifier1 = "EE_AddCell"
    let headerIdentifier = "UICollectionReusableView"
    let numberOfLine: CGFloat = 3.0
    let cellPadding: CGFloat = 15.0
    let maxImageCount = 6
    
    @IBOutlet weak var nameView: UITextField!
    @IBOutlet weak var chargeView: UITextField!
    @IBOutlet weak var phoneView: UITextField!
    @IBOutlet weak var cityView: UITextField!
    @IBOutlet weak var addressText: UITextView!
    @IBOutlet weak var introduceText: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var headView: UIView!
    @IBOutlet weak var submitView: UIButton!
    @IBOutlet weak var submitViewHeight: NSLayoutConstraint!
    
    var imageArray: [PP_ImageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "考点详情"

        collectionView.register(UINib(nibName: cellIdentifier0, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier0)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        if let model = venueModel {
            self.nameView.text = model.name
            self.chargeView.text = model.charger
            self.phoneView.text = model.phone
            self.cityView.text = model.city
            self.addressText.text = model.address
            self.introduceText.text = model.introduce
            self.imageArray = model.venueImage
            
            let state = model.state == 1 ? "已审核" : "未审核"
            submitView.setTitle(state, for: .normal)
        }
        
        if isCheck {
            submitView.setTitle("通过审核", for: .normal)
        }
        else {
//            submitViewHeight.constant = 0
            submitView.isUserInteractionEnabled = false
            submitView.backgroundColor = UIColor.ColorBgGray()
        }
    }
    
    @IBAction
    func doSubmit() {
        guard let model = venueModel else {
            cmShowToast("数据错误")
            return
        }
        
        PP_GradeService.checkVenue(venueId: model.kid) { (isSuccess) in
            if isSuccess {
                NotificationCenter.default.post(name: .kNFCheckedVenue, object: nil)
                cmShowToast("审核成功")
                cmPopViewController()
            }
            else {
                cmShowToast("审核失败")
            }
        }
    }
}

extension PP_VenueDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier0, for: indexPath) as! EE_ImageCell
        
        let imageModel = self.imageArray[indexPath.row]
        cell.imageView.kf.setImage(with: URL(string: imageModel.imageUrl))
        cell.enableDelete(false)
        return cell
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
        let browser = MWPhotoBrowser(delegate: self)
        cmPushViewController(browser)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 450)
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

extension PP_VenueDetailVC: MWPhotoBrowserDelegate {
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.imageArray.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let imageModel = self.imageArray[Int(index)]
        return MWPhoto(url: URL(string: imageModel.imageUrl))
    }
}
