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
    var id:String!
    var title:String!
    var subtitle:String!
    var content:String!
    var messageId:Double!
    var topicId:Double!
    var linkUrl:String?
    var originalLinkUrl:String?
    var sourceRawValue:String!
    var collectCount:Int!
    var commentCount:Int!
    var popularity:Int!
    var repostCount:Int!
    var likeCount:Int!
    var collected:Bool!
    var liked:Bool!
    var messageType:String!
    var targetId:String!
    var pictureUrls:[Image]?
    var video:Video?
    var iconUrl:String?
    
    var media:Media?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        content <- map["content"]
        messageId <- map["messageId"]
        topicId <- map["topicId"]
        linkUrl <- map["linkUrl"]
        originalLinkUrl <- map["originalLinkUrl"]
        sourceRawValue <- map["sourceRawValue"]
        collectCount <- map["collectCount"]
        commentCount <- map["commentCount"]
        popularity <- map["popularity"]
        repostCount <- map["repostCount"]
        likeCount <- map["likeCount"]
        collected <- map["collected"]
        liked <- map["liked"]
        messageType <- map["messageType"]
        targetId <- map["targetId"]
        pictureUrls <- map["pictureUrls"]
        video <- map["video"]
    }
    
    func videoUrl(_ then: ((_ item:AVPlayerItem?)->Void)?) {
        if let media = media,
            let url = URL(string: media.url) {
            print("contain cache:\(String(describing: url))")
            var option:[String:Any]?
            if let headers = media.headers {
                option = ["AVURLAssetHTTPHeaderFieldsKey":headers as Any]
            }
            let asset = AVURLAsset(url: url, options: option)
            let item = AVPlayerItem(asset: asset)
            then?(item)
        } else {
            MediaService.shared.media(self, then: { (media, error) in
                if let media = media,
                    let urlString = media.url,
                    let url = URL(string: urlString) {
                    var option:[String:Any]?
                    if let headers = media.headers {
                        option = ["AVURLAssetHTTPHeaderFieldsKey":headers as Any]
                    }
                    let asset = AVURLAsset(url: url, options: option)
                    let item = AVPlayerItem(asset: asset)
                    then?(item)
                } else {
                    then?(nil)
                }
            })
        }
    }
}

