//
//  Message.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper
import AVKit


class Message : Mappable {
    
    // Base
    var id:String = ""
    
    // Content
    var content:String = ""

    
    // Stats
    var likeCount:Int = 0
    var repostCount:Int = 0
    var shareCount:Int = 0
    var collectCount:Int = 0
    var commentCount:Int = 0
    
    var liked:Bool = false
    var collected:Bool = false
    
    // Media
    var audio:Audio?
    var video:Video?
    var pictureUrls:[Image]?
    
    var linkInfo:Link?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        
        content <- map["content"]

        collectCount <- map["collectCount"]
        commentCount <- map["commentCount"]
        repostCount <- map["repostCount"]
        likeCount <- map["likeCount"]
        
        liked <- map["liked"]
        collected <- map["collected"]
        
        audio <- map["media"]
        video <- map["video"]
        pictureUrls <- map["pictureUrls"]
        

    }
    
    
    func deepFetchImages() -> [Image]? {
        return self.pictureUrls
    }
    
    func videoUrl(_ then: ((_ item:AVPlayerItem?)->Void)?) {
//        if let media = media,
//            let url = URL(string: media.url) {
//            print("contain cache:\(String(describing: url))")
//            var option:[String:Any]?
//            if let headers = media.headers {
//                option = ["AVURLAssetHTTPHeaderFieldsKey":headers as Any]
//            }
//            let asset = AVURLAsset(url: url, options: option)
//            let item = AVPlayerItem(asset: asset)
//            then?(item)
//        } else {
//            MediaService.shared.media(self, then: { (media, error) in
//                if let media = media,
//                    let urlString = media.url,
//                    let url = URL(string: urlString) {
//                    var option:[String:Any]?
//                    if let headers = media.headers {
//                        option = ["AVURLAssetHTTPHeaderFieldsKey":headers as Any]
//                    }
//                    let asset = AVURLAsset(url: url, options: option)
//                    let item = AVPlayerItem(asset: asset)
//                    then?(item)
//                } else {
//                    then?(nil)
//                }
//            })
//        }
    }
}

