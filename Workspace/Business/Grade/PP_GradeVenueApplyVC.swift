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

class PP_GradeVenueApplyVC: CMBaseVC {
    
    var venueModel: PP_VenueModel?
    
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
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var locationView: ChooseLocationView!
    
    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "考点申请"
        
        self.performSelector(inBackground: #selector(loadAddressData), with: nil)

        collectionView.register(UINib(nibName: cellIdentifier0, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier0)
        collectionView.register(UINib(nibName: cellIdentifier1, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier1)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        cityView.tapAction { (view) in
            self.view.endEditing(true)
            self.coverView.isHidden = false
            self.locationView.isHidden = false
            self.isEditing = false
        }
        
        locationView.chooseCancel = {
            self.coverView.isHidden = true
            self.locationView.isHidden = true
        }
        
        locationView.chooseFinish = {
            self.coverView.isHidden = true
            self.locationView.isHidden = true
            self.cityView.text = self.locationView.address
        }
        
        if let model = venueModel {
            onlyReadView(model: model)
        }
    }
    
    func onlyReadView(model: PP_VenueModel) {
        self.title = "考点详情"
        
        self.nameView.text = model.name
        self.chargeView.text = model.charger
        self.phoneView.text = model.phone
        self.cityView.text = model.city
        self.addressText.text = model.address
        self.introduceText.text = model.introduce
        self.imageArray = model.venueImages
        
        let coverView = UIView()
        self.view.addSubview(coverView)
        coverView.backgroundColor = UIColor.black
        coverView.alpha = 0.1
        coverView.snp.makeConstraints { (maker) in
            maker.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func loadAddressData() {
        CitiesDataTool.sharedManager().requestGetData()
    }
    
    @IBAction
    func doSubmit() {
        guard let name = nameView.text, name.count>0 else {
            cmShowToast("请填写考点名称")
            return
        }
        guard let charger = chargeView.text, charger.count>0 else {
            cmShowToast("请填写负责人姓名")
            return
        }
        guard let phone = phoneView.text, phone.count>0 else {
            cmShowToast("请填写联系电话")
            return
        }
        guard let city = cityView.text, city.count>0 else {
            cmShowToast("请选择所在地区")
            return
        }
        guard let address = addressText.text, address.count>0 else {
            cmShowToast("请填写详细地址")
            return
        }
        if address.count > 50 {
            cmShowToast("详细地址限制50字以内")
            return
        }
        guard let introduce = introduceText.text, introduce.count>0 else {
            cmShowToast("请填考点简介")
            return
        }
        if introduce.count > 100 {
            cmShowToast("考点简介限制100字以内")
            return
        }
        if imageArray.count == 0 {
            cmShowToast("请上传证件和场馆照片")
            return
        }
        
        let model = PP_VenueModel()
        model.name = name
        model.charger = charger
        model.phone = phone
        model.address = address
        model.introduce = introduce
        model.venueImages = self.imageArray
        
        let substrings = city.split(separator: ",")
        if substrings.count > 0 {
            model.province = String(substrings[0])
        }
        if substrings.count > 1 {
            model.city = String(substrings[1])
        }
        if substrings.count > 1 {
            model.county = String(substrings[2])
        }
        
        PP_GradeService.buildVenue(model) { (response) in
            if response.isSuccess() {
                cmShowToast("提交成功")
                cmPopViewController()
            }
            else {
                cmShowToast(response.errorInfo)
            }
        }
    }
}

extension PP_GradeVenueApplyVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == imageArray.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier1, for: indexPath) as! EE_AddCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier0, for: indexPath) as! EE_ImageCell
            cell.imageView.image = self.imageArray[indexPath.row]
            cell.enableDelete(true)
            cell.delBlock = {
                self.imageArray.remove(at: indexPath.row)
                collectionView.reloadData()
            }
            return cell
        }
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
        if (indexPath.row == imageArray.count) {
            // add
            if let imagePickerVc = TZImagePickerController(maxImagesCount: maxImageCount, delegate: self) {
                self.present(imagePickerVc, animated: true) {
                    
                }
            }
        }
        else {
            let browser = MWPhotoBrowser(delegate: self)
//            browser.displayActionButton = NO;
//            browser.alwaysShowControls = NO;
//            browser.displaySelectionButtons = NO;
//            browser.zoomPhotosToFill = YES;
//            browser.displayNavArrows = NO;
//            browser.startOnGrid = NO;
//            browser.enableGrid = YES;
            cmPushViewController(browser)
        }
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

extension PP_GradeVenueApplyVC: TZImagePickerControllerDelegate {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        self.imageArray.append(contentsOf: photos)
        self.collectionView.reloadData()
    }
}

extension PP_GradeVenueApplyVC: MWPhotoBrowserDelegate {
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.imageArray.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let image = self.imageArray[Int(index)]
        return MWPhoto(image: image)
    }
}
