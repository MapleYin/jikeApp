//
//  STImageScrollView.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/24.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class STImageScrollView: UIView {
    
    private let imageView = ImageView()
    private let scrollView = STScrollView()
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(image:UIImage) {
        imageView.image = image
        imageView.snp.remakeConstraints { (make) in
            make.center.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(imageView.snp.width).multipliedBy(image.size.height/image.size.width)
        }
    }
    
    func reset() {
        scrollView.zoomScale = 1
    }
}


extension STImageScrollView : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
