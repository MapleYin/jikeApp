//
//  MessageImageView.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/27.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MessageImageView : UIView {
    
    var imageSelectActionBlock:(([ImageView],Int)->())?
    
    private let separatorWidth:CGFloat = 3.0
    private var imageViews:[ImageView] = []
    private var images:[Image] = []
    private let containerWidth:CGFloat = UIScreen.chooseByWidth(320.0, 375.0, 414.0)
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width, height:heightForImageCount(images))
    }
    
    func setup(_ images:[Image]) {
        self.images = images
        setupImageData(images)
        setupLayout(images)
        invalidateIntrinsicContentSize()
    }
    
    private func setupImageData(_ images:[Image]) {
        reset()
        for (index,image) in images.enumerated() {
            if index < 9 {
                let imageView = imageViewAtIndex(index)
                imageView.isHidden = false
                imageView.kf.setImage(image)
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

// Action
extension MessageImageView {
    @objc private func didSelect(gesture:UIGestureRecognizer) {
        if let view = gesture.view as? ImageView,
            let index = imageViews.index(of: view){
            imageSelectActionBlock?(imageViews,index)
        }
    }
}


// Source
extension MessageImageView {
    
    func imageViewAtIndex(_ index:Int) -> ImageView {
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
    
    private func createImageView() -> ImageView {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelect(gesture:)))
        imageView.addGestureRecognizer(gesture)
        return imageView
    }
}


// Layout
extension MessageImageView {
    
    private func setupLayout(_ images:[Image]) {
        let imageCount = images.count
        for index in 0..<imageCount {
            let imageView = imageViewAtIndex(index)
            imageView.frame = rectForIndex(index, imageCount: imageCount, image: images[index])
        }
    }
    
    private func rectForIndex(_ index:Int, imageCount:Int, image:Image) -> CGRect {
//        let containerWidth = self.intrinsicContentSize.width
        var x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat
        switch imageCount {
        case 1:
            x = 0
            y = 0
            width = containerWidth
            if image.width == 0 || image.height == 0 {
                height = width
            } else {
                let rato = CGFloat(min(image.height/image.width, 0.8))
                height = width * rato
            }
            
            break;
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
                height = containerWidth / 2.0
                x = 0
                y = 0
                break
            default:
                width = (containerWidth - 2 * separatorWidth) / 3.0
                height = width
                x = CGFloat(index - 1) * (width + separatorWidth)
                y = CGFloat((index + 2) / 3) * (containerWidth / 2.0 + separatorWidth)
                break
            }
            break
        case 5,8:
            switch index {
            case 0,1:
                width = (containerWidth - separatorWidth) / 2.0
                height = width
                x = CGFloat(index) * (width + separatorWidth)
                y = 0
                break
            default:
                width = (containerWidth - 2 * separatorWidth) / 3.0
                height = width
                x = CGFloat(index - 2).truncatingRemainder(dividingBy: 3) * (width + separatorWidth)
                y = ((containerWidth - separatorWidth) / 2.0 + separatorWidth) + CGFloat(index / 5) * (height + separatorWidth)
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
    
    private func heightForImageCount(_ images:[Image]) -> CGFloat {
//        let containerWidth = self.intrinsicContentSize.width
        let imageCount = images.count
        var height:CGFloat
        switch imageCount {
        case 1:
            let image = images.first!
            let rato = CGFloat(min(image.height/image.width, 0.8))
            height = containerWidth * rato
            break
        case 2:
            height = containerWidth / 5 * 2
            break
        case 3,6,9:
            height = CGFloat(imageCount / 3) * ((containerWidth - 2 * separatorWidth) / 3.0) + CGFloat(imageCount / 3 - 1) * separatorWidth
            break
        case 4,7:
            height = containerWidth / 2.0 + separatorWidth + CGFloat(imageCount / 3) * (containerWidth - 2 * separatorWidth) / 3.0 + CGFloat(imageCount / 3 - 1) * separatorWidth
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
