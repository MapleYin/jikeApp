//
//  STHJMessageImageView.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher

class STHJMessageImageView: UIImageView {
    
    var sizeArea:CGSize?
    
    func setup(_ image:Image) {
        let url = URL(string: image.smallPicUrl)
        self.kf.setImage(with: url)
        if let size = sizeWithImageSize(CGSize(width: CGFloat(image.width), height: CGFloat(image.height))) {
            self.snp.updateConstraints { (make) in
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
                returnSize = CGSize(width: ceil(imageRatio * size.height), height: ceil(size.height))
            } else {
                returnSize = CGSize(width: ceil(size.width), height: ceil(size.width / imageRatio))
            }
        }
        
        return returnSize;
    }

}
