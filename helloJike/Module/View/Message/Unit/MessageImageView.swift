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
    
    var imageView = UIImageView()
    
    init() {
        super.init(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(self)
            make.height.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ image:Image) {
        let url = URL(string: image.middlePicUrl)
        imageView.kf.setImage(with: url)
        
        let rato = CGFloat(min(image.height/image.width, 0.8))
        
        imageView.snp.updateConstraints { (make) in
            make.height.equalTo(Int(UIScreen.main.bounds.width * rato))
        }
        
        
    }
}
