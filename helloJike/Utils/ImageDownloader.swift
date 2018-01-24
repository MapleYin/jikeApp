//
//  ImageDownloader.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/24.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Kingfisher
import KingfisherWebP

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

extension ImageDownloader {
    @discardableResult
    func downloadImage(image:Image, quality:Quality = .low, progressBlock:ImageDownloaderProgressBlock? = nil, completionHandler:ImageDownloaderCompletionHandler? = nil) -> RetrieveImageDownloadTask? {
        if let url = URL(string: quality.url(image)) {
            var option:KingfisherOptionsInfo?
            if image.format == "webp" {
                option = [.processor(WebPProcessor.default),.cacheSerializer(WebPSerializer.default)]
            }
            
            return self.downloadImage(with: url, retrieveImageTask: nil, options: option, progressBlock: progressBlock, completionHandler: completionHandler)
        } else {
            return nil
        }
    }
}

extension Kingfisher where Base: ImageView {
    @discardableResult
    func setImage(_ image:Image, quality:Quality = .low, progressBlock:DownloadProgressBlock? = nil, completionHandler:CompletionHandler? = nil) -> RetrieveImageTask {
        let url = URL(string: quality.url(image))
        var option:KingfisherOptionsInfo?
        if image.format == "webp" {
            option = [.processor(WebPProcessor.default),.cacheSerializer(WebPSerializer.default)]
        }
        return self.setImage(with: url, placeholder: nil, options: option, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}
