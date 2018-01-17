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
    
    let containerView = UIScrollView()
    let imageView = UIImageView()

    class var identifier:String {
        return "ImageCollectionCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.delegate = self
        containerView.maximumZoomScale = 3
        containerView.minimumZoomScale = 1
        containerView.zoomScale = 1
        
        containerView.addSubview(imageView)
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ message:Image) {
        let width = self.contentView.bounds.width
        let heigh = self.contentView.bounds.height
        let rato = width / heigh
        if let url = URL(string: message.picUrl) {
            imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                
            }, completionHandler: { (image, error, type, loadUrl) in
                if let image = image {
                    let size = image.size
                    let imageRato = size.width / size.height
                    
                    if imageRato > rato {
                        // 屏幕内
                        self.imageView.snp.remakeConstraints({ (make) in
                            make.center.equalTo(self.containerView)
                            make.width.equalTo(self.containerView)
                            make.height.equalTo(self.imageView.snp.width).dividedBy(imageRato)
                        })
                    } else {
                        // 屏幕外
                        self.imageView.snp.remakeConstraints({ (make) in
                            make.centerX.equalTo(self.containerView)
                            make.top.equalTo(self.containerView)
                            make.width.equalTo(self.containerView)
                            make.height.equalTo(self.imageView.snp.width).dividedBy(imageRato)
                        })
                    }
                    
                    self.containerView.contentSize = CGSize(width: width, height:width / imageRato)
                }
            })
        }
    }
}


// UIScrollViewDelegate
extension ImageCollectionCell {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

