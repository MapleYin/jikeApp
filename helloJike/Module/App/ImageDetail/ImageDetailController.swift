//
//  ImageDetailController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher

class ImageDetailController: STViewController {
    
    var imageCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
    var images:[Image] = []
    var currentDisplayIndex = 0
    var sourceImageViews:[ImageView] = []
    
    var downloadMap:[Int:RetrieveImageTask] = [:]
    
    convenience init(_ images:[Image], selected index:Int = 0, source imageViews:[ImageView]) {
        self.init()
        self.images = images
        self.currentDisplayIndex = index
        self.sourceImageViews = imageViews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = view.safeAreaLayoutGuide.layoutFrame.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        view.addSubview(imageCollectionView)
        
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self
        imageCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        imageCollectionView.setCollectionViewLayout(layout, animated: false)
        
        imageCollectionView.snp.makeConstraints { (make) in
            var edge = view.safeAreaInsets
            edge.left = -5
            edge.right = -5
            make.edges.equalTo(view).inset(edge)
        }
        
        let indexPath = IndexPath(row: currentDisplayIndex, section: 0)
        imageCollectionView.layoutIfNeeded()
        imageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func dismissController() {
        dismiss(animated: true)
    }
    
    @objc func tap(_ gesture:UIGestureRecognizer) {
        if gesture.numberOfTouches == 1 {
            dismissController()
        }
    }
    
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
}


// Public

extension ImageDetailController {
    func currentImageView() -> (ImageView,Int)? {
        imageCollectionView.layoutIfNeeded()
        if let cell = imageCollectionView.visibleCells.first as? ImageCollectionCell {
            let indexPath = imageCollectionView.indexPath(for: cell)
            return (cell.imageScrollView.imageView,indexPath!.row)
        }
        return nil
    }
}


// UICollectionViewDelegate
extension ImageDetailController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// UICollectionViewDataSource
extension ImageDetailController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as! ImageCollectionCell
        let image = self.images[indexPath.row]
        let imageView = self.sourceImageViews[indexPath.row]
        cell.setup(image, sourceImageView: imageView)
        return cell
    }
    
}


extension ImageDetailController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            let image = images[indexPath.row]
            let imageView = self.sourceImageViews[indexPath.row]
            downloadMap[indexPath.row] = DownloadImage(image: image, quality: .high, completionHandler: { (image, error, type, url) in
                if let image = image {
                    imageView.image = image
                }
                self.downloadMap[indexPath.row] = nil
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            if let task = downloadMap[indexPath.row] {
                task.cancel()
                self.downloadMap[indexPath.row] = nil
            }
        }
    }
}
