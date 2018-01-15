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
    
    private let containerWidth:CGFloat = UIScreen.chooseByWidth(300.0, 320.0, 400.0)
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: containerWidth, height:heightForImageCount(currentImageCount))
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
        var x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat
        switch imageCount {
        case 2:
            width = containerWidth / 5 * 2
            height = width
            x = (width + separatorWidth) * CGFloat(index)
            y = 0
            break
        case 4,7:
            switch index {
            case 0:
                width = containerWidth
                height = containerWidth / 3.0
                x = 0
                y = 0
                break
            default:
                width = (containerWidth - 2 * separatorWidth) / 3.0
                height = width
                x = CGFloat(index - 1) * width
                y = CGFloat((index + 2) / 3) * (containerWidth / 3.0 + separatorWidth)
                break
            }
            break
        case 5,8:
            switch index {
            case 0:
                width = (containerWidth - separatorWidth) / 2.0
                height = width
                x = CGFloat(index) * (width + separatorWidth)
                y = 0
                break
            default:
                width = (containerWidth - 2 * separatorWidth) / 3.0
                height = width
                x = CGFloat(index - 2) * width
                y = CGFloat((index + 1) / 3) * (containerWidth / 2.0 + separatorWidth)
                break
            }
            break
        case 3,6,9:
            width = (containerWidth - 2 * separatorWidth) / 3.0
            height = width
            x = CGFloat(index).truncatingRemainder(dividingBy: 3) * (width + separatorWidth)
            y = CGFloat(index / 3) * (height + separatorWidth)
            break
        default:
            x = 0
            y = 0
            width = 0
            height = 0
            break
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func heightForImageCount(_ imageCount:Int) -> CGFloat {
        var height:CGFloat
        switch imageCount {
        case 2:
            height = containerWidth / 5 * 2
            break;
        case 3,6,9:
            height = CGFloat(imageCount / 3) * ((containerWidth - 2 * separatorWidth) / 3.0) + CGFloat(imageCount / 3 - 1) * separatorWidth
            break
        case 4,7:
            height = containerWidth / 3.0 + separatorWidth + CGFloat(imageCount / 3) * (containerWidth - 2 * separatorWidth) / 3.0 + CGFloat(imageCount / 3 - 1) * separatorWidth
            break
        case 5,8:
            height = (containerWidth - separatorWidth) / 2.0 + separatorWidth + CGFloat(imageCount / 3) * (containerWidth - 2 * separatorWidth) / 3.0 + CGFloat(imageCount / 3 - 1) * separatorWidth
            break
        default:
            height = 0
            break
        }
        
        return height
    }
}
