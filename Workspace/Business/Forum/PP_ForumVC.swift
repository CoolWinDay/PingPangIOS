//
//  PP_ForumVC.swift
//  PingPangWang
//
//  Created by 李鹏 on 2018/4/13.
//  Copyright © 2018年 com.jsinda. All rights reserved.
//

import UIKit

class PP_ForumVC: CMBaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellRICell = "PP_ForumCell"
    let cellRIHeader = "PP_ForumHeaderView"
    
    var forumList: [PP_ForumModel?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 10)
        collectionView.register(UINib(nibName: cellRICell, bundle: Bundle.main), forCellWithReuseIdentifier: cellRICell)
        collectionView.register(UINib(nibName: cellRIHeader, bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellRIHeader)
        
        ForumService.forumList { (forumList) in
            self.forumList = forumList
            self.collectionView.reloadData()
        }
    }

}

extension PP_ForumVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return forumList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = forumList[section] {
            return model.board_list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = floor((collectionView.bounds.width-1)*0.5)
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRICell, for: indexPath) as! PP_ForumCell
        cell.cellWithModel(forumList[indexPath.section]?.board_list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellRIHeader, for: indexPath) as! PP_ForumHeaderView
        if let model = forumList[indexPath.section] {
            headerView.titleView.text = model.board_category_name
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = forumList[indexPath.section]?.board_list[indexPath.row] {
            let vc = PP_TopicVC()
            vc.title = model.board_name
            vc.board_id = model.board_id
            cmPushViewController(vc)
        }
    }
}
