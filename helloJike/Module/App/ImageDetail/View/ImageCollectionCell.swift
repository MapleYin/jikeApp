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
    
    
    func setup(_ image:Image) {
        self.indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        print(self)
        
        print("cancel downloadTask?.url:\(String(describing: task?.downloadTask?.url))")
        task?.cancel()
        
        print("Begin DownloadImage url:\(String(describing: Quality.high.url(image)))")
        task = DownloadImage(image: image, quality: .high, progressBlock: { (recive, total) in

        }) { (image, error, cacheType, imageURL) in
            print(self)
            print("End DownloadImage url:\(String(describing: imageURL))")
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

