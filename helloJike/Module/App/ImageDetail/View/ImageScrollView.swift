//
//  ImageScrollView.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/24.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageScrollView: UIView {
    
    let imageView = ImageView()
    private let scrollView = STScrollView()
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setup(image:Image, sourceImageView:ImageView? = nil) {
        indicatorView.startAnimating()
        imageView.setImage(image, quality: .high, placeholder: sourceImageView?.image, progressBlock: nil) { (image, error, type, url) in
            if image != nil {
                sourceImageView?.image = image
            }
            self.indicatorView.stopAnimating()
        }
        
        self.imageView.snp.remakeConstraints { (make) in
            make.center.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.imageView.snp.width).multipliedBy(image.height/image.width)
        }
    }
    
    func reset() {
        imageView.image = nil
        scrollView.zoomScale = 1
        scrollView.contentOffset = CGPoint.zero
    }
}


extension ImageScrollView : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
