//
//  MessageMultipleImageView.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/27.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher

class MessageMultipleImageView: UIView {
    
    private var imageViews:[UIImageView] = []
    private var currentImageCount = 0
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let section = currentImageCount / 3
        return CGSize(width: size.width, height:CGFloat(section+1)*100.0)
    }
    
    func setup(_ images:[Image]) {
        currentImageCount = images.count
        setupImageData(images)
        setupLayout(currentImageCount)
        invalidateIntrinsicContentSize()
    }
    
    private func setupImageData(_ images:[Image]) {
        for (index,image) in images.enumerated() {
            if index < 9 {
                let imageView = imageViewAtIndex(index)
                let url = URL(string: image.smallPicUrl)
                imageView.kf.setImage(with: url)
            }
        }
    }
    
    private func setupImageView() {
        for section in 1...3 {
            for row in 1...3 {
                let imageView = imageViewAtIndex(section*3+row)
                imageView.frame = CGRect(x: row*100, y: section*100, width: 100, height: 100)
            }
        }
    }
    
    private func setupLayout(_ imageCount:Int) {
        
    }
    
    private func imageViewAtIndex(_ index:Int) -> UIImageView {
        if index > imageViews.count {
            var length = index - imageViews.count
            while length > 0 {
                let imageView = createImageView()
                addSubview(imageView)
                imageViews.append(imageView)
                length = length - 1
            }
        }
        
        return imageViews[index]
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return imageView
    }
}
