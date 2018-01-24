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
    var task:RetrieveImageTask?
    var imageData:Image?
    
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    class var identifier:String {
        return "ImageCollectionCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageScrollView)
        contentView.addSubview(indicatorView)
        
        imageScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ imageData:Image) {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        self.imageData = imageData
        task?.cancel()
        task = DownloadImage(image: imageData, quality: .high, progressBlock: nil) { (image, error, cacheType, imageURL) in
            if Quality.high.url(self.imageData!) != imageURL?.absoluteString {
                return
            }
            if let image = image {
                self.imageScrollView.setup(image: image)
            }
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
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

