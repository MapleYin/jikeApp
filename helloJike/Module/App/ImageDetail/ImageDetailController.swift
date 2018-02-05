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
            make.top.bottom.equalTo(view)
            make.leading.equalTo(view).offset(-5)
            make.trailing.equalTo(view).offset(5)
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
    
    deinit {
        print("ImageDetailController deinit")
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
            imageView.setImage(image, quality: .high, placeholder: imageView.image, progressBlock: nil, completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    }
}
