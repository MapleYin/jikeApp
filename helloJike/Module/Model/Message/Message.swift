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
    var abstrct:String?
    var content:String?
    var messageId:Double!
    var topicId:Double!
    var topic:Topic!
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
    var updatedAt:Date!
    var createdAt:Date!
    
    var media:Media?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        messageId <- map["messageId"]
        content <- map["content"]
        abstrct <- map["abstrct"]
        topicId <- map["topicId"]
        topic <- map["topic"]
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
        iconUrl <- map["iconUrl"]
        updatedAt <- (map["updatedAt"],DefaultDateTransform())
        createdAt <- (map["createdAt"],DefaultDateTransform())
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

