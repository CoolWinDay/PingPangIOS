//
//  PP_AuditorApplyVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/6/18.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit
import TZImagePickerController
import MWPhotoBrowser

class PP_AuditorApplyVC: CMBaseVC {

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
    @IBOutlet weak var introduceText: UITextView!
    @IBOutlet weak var cityView: UITextField!
    @IBOutlet weak var nevueView: UITextField!
    @IBOutlet weak var sex0View: UIButton!
    @IBOutlet weak var sex1View: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var headView: UIView!
    @IBOutlet weak var submitView: UIButton!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var locationView: ChooseLocationView!
    
    var avatarImage: UIImage?
    var imageArray: [PP_ImageModel] = []
    var venue_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "考官申请"
        
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
        
        nevueView.tapAction { (view) in
            self.view.endEditing(true)
            
            let vc = PP_VenueSelectVC()
            if let address = self.cityView.text, address.count > 0 {
                vc.address = address
            }
            vc.callBack = { (model) in
                self.venue_id = model.kid
                self.nevueView.text = model.name
            }
            cmPushViewController(vc)
        }
    }
    
    func loadAddressData() {
        CitiesDataTool.sharedManager().requestGetData()
    }
    
    @IBAction
    func sexRadioButton(button: UIButton) {
        let manSel = button.tag == 101
        self.sex0View.isSelected = manSel
        self.sex1View.isSelected = !manSel
    }
    
    @IBAction
    func selAvatar() {
        if let picker = TZImagePickerController(maxImagesCount: 1, delegate: self) {
            picker.view.tag = 101
            self.present(picker, animated: true)
        }
    }
    
    @IBAction
    func doSubmit() {
        
        guard let name = nameView.text, name.count>0 else {
            cmShowToast("请填写姓名")
            return
        }
        guard let age = ageView.text, age.count>0 else {
            cmShowToast("请填写年龄")
            return
        }
        guard let phone = phoneView.text, phone.count>0 else {
            cmShowToast("请填写联系电话")
            return
        }
        guard let idcard = idcardView.text, idcard.count>0 else {
            cmShowToast("请填写身份证号")
            return
        }
        guard let introduce = introduceText.text, introduce.count>0 else {
            cmShowToast("请填写自我介绍")
            return
        }
        if introduce.count > 100 {
            cmShowToast("自我介绍限制在100字内")
            return
        }
        guard let city = cityView.text, city.count>0 else {
            cmShowToast("请选择现居地区")
            return
        }
        guard let venue = nevueView.text, venue.count>0 else {
            cmShowToast("请选择所在考点")
            return
        }
        
        guard let avatarImage = self.avatarImage else {
            cmShowToast("请选择头像图片")
            return
        }
        
        if imageArray.count == 0 {
            cmShowToast("请上相关证书")
            return
        }
        
        let sex = sex0View.isSelected ? sex0View.titleLabel!.text! : sex1View.titleLabel!.text!
        
        let model = PP_AuditorModel()
        model.name = name
        model.sex = sex
        model.age = age
        model.phone = phone
        model.idcard = idcard
        model.introduce = introduce
        model.venueid = venue_id
        model.certificateImage = self.imageArray
        let imageModel = PP_ImageModel()
        imageModel.image = avatarImage
        model.avatarImage = imageModel
        
        PP_GradeService.buildAuditor(model) { (response) in
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

extension PP_AuditorApplyVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
            cell.imageView.image = self.imageArray[indexPath.row].image
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
        return CGSize(width: collectionView.bounds.width, height: 520)
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

extension PP_AuditorApplyVC: TZImagePickerControllerDelegate {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        if picker.view.tag == 101 {
            if photos.count > 0 {
                avatarView.setImage(photos[0], for: .normal)
                avatarImage = photos[0]
            }
        }
        else {
            for image in photos {
                let model = PP_ImageModel()
                model.image = image
                self.imageArray.append(model)
            }
            self.collectionView.reloadData()
        }
    }
}

extension PP_AuditorApplyVC: MWPhotoBrowserDelegate {
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.imageArray.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let model = self.imageArray[Int(index)]
        return MWPhoto(image: model.image)
    }
}
