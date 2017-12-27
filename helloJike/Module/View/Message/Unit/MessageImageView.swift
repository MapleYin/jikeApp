//
//  MessageImageView.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class MessageImageView: UIView {
    var sizeArea:CGSize?
    var imageView = UIImageView()
    
    init() {
        super.init(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalTo(self).priority(ConstraintPriority.medium)
            make.size.equalTo(CGSize.zero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let size = imageView.intrinsicContentSize
        if let contentSize = sizeWithImageSize(size) {
            return contentSize
        }
        return size
    }
    
    func setup(_ image:Image) {
        let url = URL(string: image.smallPicUrl)
        imageView.kf.setImage(with: url)
        if let size = sizeWithImageSize(CGSize(width: CGFloat(image.width), height: CGFloat(image.height))) {
            imageView.snp.updateConstraints { (make) in
                make.size.equalTo(size)
            }
        }
        
    }
    
    private func sizeWithImageSize(_ imageSize:CGSize) -> CGSize? {
        var returnSize:CGSize?;
        if let size = self.sizeArea {
            let width = imageSize.width;
            let height = imageSize.height;
            
            if width < size.width && height < size.height {
                return CGSize(width: width, height: height)
            }
            
            let imageRatio = width / height
            let sizeRatio = size.width / size.height
            
            if imageRatio < sizeRatio {
                var displayWidth = ceil(imageRatio * size.height)
                if height > 800 {
                    displayWidth = min(size.width, width)
                }
                returnSize = CGSize(width: displayWidth, height: ceil(size.height))
            } else {
                returnSize = CGSize(width: ceil(size.width), height: ceil(size.width / imageRatio))
            }
        }
        
        return returnSize;
    }
}
