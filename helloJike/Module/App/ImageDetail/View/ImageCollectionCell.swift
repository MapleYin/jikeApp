//
//  ImageCollectionCell.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell,UIScrollViewDelegate {
    
    var containerView = STScrollView()
    let imageView = ImageView()

    class var identifier:String {
        return "ImageCollectionCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView = STScrollView(frame: frame)
        containerView.delegate = self
        containerView.maximumZoomScale = 3
        containerView.minimumZoomScale = 1
        containerView.alwaysBounceVertical = true
        
        containerView.addSubview(imageView)
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ image:Image) {
        let width = self.contentView.bounds.width
        let heigh = self.contentView.bounds.height
        let rato = width / heigh

        imageView.setup(image, quality:.high, progressBlock: nil) { (image, error, type, loadUrl) in
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
        }
    }
}


// UIScrollViewDelegate
extension ImageCollectionCell {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

