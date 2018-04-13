//
//  ImageVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/17.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import Kingfisher

class ImageVC: CMBaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kingfisher"
        
        collectionView?.register(UINib(nibName: "ImageCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    @IBAction func clearCache(sender: AnyObject) {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
    }
    
    @IBAction func reload(sender: AnyObject) {
        collectionView?.reloadData()
    }
}

extension ImageVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // This will cancel all unfinished downloading task when the cell disappearing.
        (cell as! ImageCell).cellImageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-\(indexPath.row + 1).jpg")!
        
        _ = (cell as! ImageCell).cellImageView.kf.setImage(with: url,
                                                                    placeholder: nil,
                                                                    options: [.transition(ImageTransition.fade(1)), .keepCurrentImageWhileLoading],
                                                                    progressBlock: { receivedSize, totalSize in
                                                                        print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
        },
                                                                    completionHandler: { image, error, cacheType, imageURL in
                                                                        print("\(indexPath.row + 1): Finished")
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuseIdentifier", for: indexPath) as! ImageCell
        
        cell.cellImageView.kf.indicatorType = .activity
        
        return cell
    }
}

//extension ImageVC: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        let urls = indexPaths.flatMap {
//            URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-\($0.row + 1).jpg")
//        }
//        
//        ImagePrefetcher(urls: urls).start()
//    }
//}
