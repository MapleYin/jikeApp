//
//  ImageView.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/17.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

class ImageView: UIImageView {
    convenience init(_ image:Image) {
        self.init()
        let url = URL(string: image.smallPicUrl)
        var option:KingfisherOptionsInfo?
        if image.format == "webp" {
            option = [.processor(WebPProcessor.default),.cacheSerializer(WebPSerializer.default)]
        }
        self.kf.setImage(with: url, placeholder: nil, options: option, progressBlock: nil, completionHandler: nil)
    }
}
