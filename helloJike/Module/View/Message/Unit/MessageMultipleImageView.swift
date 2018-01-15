//
//  MessageMultipleImageView.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/27.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher

class MessageMultipleImageView : UIView {
    
    private let separatorWidth:CGFloat = 3.0
    
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
        reset()
        for (index,image) in images.enumerated() {
            if index < 9 {
                let imageView = imageViewAtIndex(index)
                imageView.isHidden = false
                let url = URL(string: image.smallPicUrl)
                imageView.kf.setImage(with: url)
            }
        }
    }
    
    func reset() {
        for (_,imageView) in imageViews.enumerated() {
            imageView.image = nil
            imageView.isHidden = true
        }
    }
}


// Source
extension MessageMultipleImageView {
    
    private func imageViewAtIndex(_ index:Int) -> UIImageView {
        if index >= imageViews.count {
            var length = index - imageViews.count
            while length >= 0 {
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}


// layout
extension MessageMultipleImageView {
    
    private func setupLayout(_ imageCount:Int) {
        layoutIfNeeded()
        for index in 0..<imageCount {
            let imageView = imageViewAtIndex(index)
            imageView.frame = rectForIndex(index, imageCount: imageCount)
        }
    }
    
    private func rectForIndex(_ index:Int, imageCount:Int) -> CGRect {
        let containerWidth:CGFloat = UIScreen.chooseByWidth(300.0, 320.0, 400.0)
        var x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat
        switch imageCount {
        case 1:
            break
        case 2:
            width = containerWidth/5*2
            height = width
            x = (width + separatorWidth) * CGFloat(index)
            y = 0
            break
        case 3:
            width = (containerWidth-2*separatorWidth)/3.0
            height = width
            x = (width + separatorWidth) * CGFloat(index)
            y = 0
            break
        case 4:
            switch index {
            case 0:
                width = containerWidth
                height = containerWidth/3.0
                x = 0
                y = 0
                break
            default:
                width = (containerWidth-2*separatorWidth)/3.0
                height = width
                x = CGFloat(index - 1) * width
                y = containerWidth/3.0+separatorWidth
                break
            }
            return CGRect(x: x, y: y, width: width, height: height);
        case 9:
            let size = CGSize(width: (containerWidth-2*separatorWidth)/3, height: (containerWidth-2*separatorWidth)/3)
            let x = CGFloat(index).truncatingRemainder(dividingBy: 3) * (size.width + separatorWidth)
            let y = CGFloat(index / 3) * ( size.height + separatorWidth )
            return CGRect(x: x, y: y, width: size.width, height: size.height);
        default:
            x = y = width = height
            break
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func heightForImageCount(_ imageCount:Int) -> CGFloat {
        return 0
    }
}
