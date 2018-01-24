//
//  ImageDetailController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageDetailController: STViewController {
    
    var imageCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
    let closeButton = UIButton(type: .custom)
    var images:[Image] = []
    
    convenience init(_ images:[Image]) {
        self.init()
        self.images = images
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = view.safeAreaLayoutGuide.layoutFrame.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        imageCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self
        imageCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        view.addSubview(imageCollectionView)
        
        imageCollectionView.snp.makeConstraints { (make) in
            var edge = view.safeAreaInsets
            edge.left = -5
            edge.right = -5
            make.edges.equalTo(view).inset(edge)
        }
        
        
        closeButton.setTitle("X", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(20)
            make.top.equalTo(view).offset(view.safeAreaInsets.top)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}


// UICollectionViewDelegate
extension ImageDetailController : UICollectionViewDelegate {
    
}

// UICollectionViewDataSource
extension ImageDetailController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as! ImageCollectionCell
        let image = self.images[indexPath.row]
        cell.setup(image)
        return cell
    }
}


extension ImageDetailController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            let image = images[indexPath.row]
            print("prefetchItemsAt:\(indexPath.row)")
            DownloadImage(image: image, quality: .high)
        }
        
    }
}
