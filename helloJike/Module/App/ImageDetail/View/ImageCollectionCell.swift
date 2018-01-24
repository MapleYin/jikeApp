//
//  ImageCollectionCell.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionCell: UICollectionViewCell,UIScrollViewDelegate {
    
    var imageScrollView = STImageScrollView()

    class var identifier:String {
        return "ImageCollectionCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageScrollView)
        
        imageScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ image:Image) {
        KingfisherManager.shared.downloader.downloadImage(image: image, quality: .high, progressBlock: { (recive, total) in
            
        }) { (image, error, url, data) in
            if let image = image {
                self.imageScrollView.setup(image: image)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageScrollView.reset()
        
    }
}


// UIScrollViewDelegate
extension ImageCollectionCell {

}

