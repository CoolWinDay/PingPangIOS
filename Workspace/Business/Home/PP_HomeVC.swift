//
//  PP_HomeVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/7/30.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_HomeVC: CMBaseVC {
    
    let cellRI = "HomeIconCell"
    let cellRI1 = "PP_HomeAuditorCell"
    let headerRI = "PP_HomeHeaderView"
    
    let numberOfLine: CGFloat = 4.0
    let cellPadding: CGFloat = 15.0
    
    var auditorList: [PP_AuditorModel?] = []
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        
        collectionView.register(UINib(nibName: cellRI, bundle: Bundle.main), forCellWithReuseIdentifier: cellRI)
        collectionView.register(UINib(nibName: cellRI1, bundle: Bundle.main), forCellWithReuseIdentifier: cellRI1)
        collectionView.register(UINib(nibName: headerRI, bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerRI)
        
        
        PP_GradeService.topAuditorList({ (auditorList) in
            if let list = auditorList {
                self.auditorList = list
                self.collectionView.reloadData()
            }
        })
    }

}

extension PP_HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        }
        else if section == 1 {
            return auditorList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRI, for: indexPath) as! HomeIconCell
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRI1, for: indexPath) as! PP_HomeAuditorCell
            
            if let model = auditorList[indexPath.row] {
                cell.cellWithData(model)
                cell.orderView.text = "No.\(indexPath.row)"
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let cellWidth = floor((collectionView.bounds.width - 20*2 - (numberOfLine-1)*cellPadding) / numberOfLine)
            return CGSize(width: cellWidth, height: cellWidth*1)
        }
        else if indexPath.section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 100)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if section == 0 {
            return cellPadding
        }
        else if section == 1 {
            return 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if section == 0 {
            return cellPadding
        }
        else if section == 1 {
            return 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsetsMake(cellPadding, 20, cellPadding, 20)
        }
        else if section == 1 {
            return UIEdgeInsetsMake(0, 0, cellPadding, 0)
        }
        
        return UIEdgeInsets.zero
    }
    
    // header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            if kind == UICollectionElementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerRI, for: indexPath) as! PP_HomeHeaderView
                headerView.titleView.text = "考官排行"
                return headerView
            }
        }
        
        return UICollectionReusableView()
    }
}
