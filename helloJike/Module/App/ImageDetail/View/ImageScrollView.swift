//
//  ImageScrollView.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/24.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageScrollView: UIView {
    
    private let imageView = ImageView()
    private let scrollView = STScrollView()
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.contentInsetAdjustmentBehavior = .never
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

    func setup(image:Image) {
        indicatorView.startAnimating()
        imageView.setImage(image, quality: .high, progressBlock: nil) { (image, error, type, url) in
            if let image = image {
                self.imageView.snp.remakeConstraints { (make) in
                    make.center.equalTo(self.scrollView)
                    make.width.equalTo(self.scrollView)
                    make.height.equalTo(self.imageView.snp.width).multipliedBy(image.size.height/image.size.width)
                }
            }
            self.indicatorView.stopAnimating()
        }
    }
    
    func reset() {
        imageView.image = nil
        scrollView.zoomScale = 1
    }
}


extension ImageScrollView : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
