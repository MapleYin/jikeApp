//
//  ImageCollectionCell.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionCell: UICollectionViewCell {
    
    var imageScrollView = ImageScrollView()

    class var identifier:String {
        return "ImageCollectionCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageScrollView)
        
        imageScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ image:Image, sourceImageView:ImageView? = nil) {
        self.imageScrollView.setup(image: image, sourceImageView: sourceImageView)
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageScrollView.reset()
    }
}


