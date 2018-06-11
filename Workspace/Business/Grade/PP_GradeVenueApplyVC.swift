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
    
    let cellIdentifier0 = "EE_ImageCell"
    let cellIdentifier1 = "EE_AddCell"
    let headerIdentifier = "UICollectionReusableView"
    let numberOfLine: CGFloat = 3.0
    let cellPadding: CGFloat = 15.0
    
    @IBOutlet weak var nameView: UITextField!
    @IBOutlet weak var chargeView: UITextField!
    @IBOutlet weak var phoneView: UITextField!
    @IBOutlet weak var cityView: UITextField!
    @IBOutlet weak var addressText: UITextView!
    @IBOutlet weak var introduceText: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var headView: UIView!
    @IBOutlet weak var submitView: UIButton!
    
    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: cellIdentifier0, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier0)
        collectionView.register(UINib(nibName: cellIdentifier1, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier1)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        initView()
    }
    
    func initView() {
        
    }
}

extension PP_GradeVenueApplyVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
            if let imagePickerVc = TZImagePickerController(maxImagesCount: 6, delegate: self) {
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
