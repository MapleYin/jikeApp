//
//  STHJMessageImageView.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class STHJMessageImageView: UIImageView {

    override var intrinsicContentSize: CGSize {
        if let image = self.image,
            let size = self.sizeArea {
            let width = image.size.width;
            let height = image.size.width;
            
            if width < size.width && height < size.height {
                return CGSize(width: width, height: height)
            }
            
            let imageRatio = width / height
            let sizeRatio = size.width / size.height
            
            if imageRatio < sizeRatio {
                
                return CGSize(width: imageRatio * size.height, height: size.height)
            } else {
                
                return CGSize(width: size.width, height: size.width / imageRatio)
            }
        }
        return super.intrinsicContentSize
    }
    
    var sizeArea:CGSize?

}
