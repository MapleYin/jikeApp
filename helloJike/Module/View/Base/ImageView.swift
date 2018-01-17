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
    
    enum Quality {
        case pool,low,middle,high
        func url(_ image:Image) -> String {
            var urlString:String
            switch self {
            case .pool:
                urlString = image.thumbnailUrl
                break
            case .low:
                urlString = image.smallPicUrl
                break
            case .middle:
                urlString = image.middlePicUrl
                break
            case .high:
                urlString = image.picUrl
                break
            }
            
            return urlString
        }
    }
    
    convenience init(_ image:Image) {
        self.init()
        let url = URL(string: image.smallPicUrl)
        var option:KingfisherOptionsInfo?
        if image.format == "webp" {
            option = [.processor(WebPProcessor.default),.cacheSerializer(WebPSerializer.default)]
        }
        self.kf.setImage(with: url, placeholder: nil, options: option, progressBlock: nil, completionHandler: nil)
    }
    
    
    func setup(_ image:Image, quality:Quality = .low, progressBlock:DownloadProgressBlock? = nil, completionHandler:CompletionHandler? = nil) {
        let url = URL(string: quality.url(image))
        var option:KingfisherOptionsInfo?
        if image.format == "webp" {
            option = [.processor(WebPProcessor.default),.cacheSerializer(WebPSerializer.default)]
        }
        self.kf.setImage(with: url, placeholder: nil, options: option, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}
