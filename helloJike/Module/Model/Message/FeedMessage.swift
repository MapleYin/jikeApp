//
//  FeedMessage.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class FeedMessage : Message {
    
    enum msgType:String {
        case article = "article"
        case normal
        
        init(rawValue:String) {
            switch rawValue {
            case "article":
                self = .article
                break;
            default:
                self = .normal
            }
        }
    }
    
    
    // Base
    var messageId:Int = 0
    
    
    // Content
    var abstract:String?
    var iconUrl:String = ""
    
    //
    var createdAt:Date = Date()
    var updatedAt:Date = Date()
    var isCommentForbidden:Bool = false
    
    // Source
    var linkUrl:String = ""
    var originalLinkUrl:String = ""
    var sourceRawValue = ""
    
    
    var personalUpdate: UserMessage?
    
    var topic: Topic?

    override func mapping(map: Map) {
        super.mapping(map: map)
        
        messageId <- map["messageId"]
        type <- map["type"]
        
        abstract <- map["abstract"]
        iconUrl <- map["iconUrl"]
        
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        isCommentForbidden <- map["isCommentForbidden"]
        
        linkUrl <- map["linkUrl"]
        originalLinkUrl <- map["originalLinkUrl"]
        sourceRawValue <- map["sourceRawValue"]
        
        personalUpdate <- map["personalUpdate"]
        
        topic <- map["topic"]
    }
    
    override func deepFetchImages() -> [Image]? {
        if let images = super.deepFetchImages(),
            images.count > 0 {
            return images
        } else {
            return  self.personalUpdate?.deepFetchImages()
        }
    }
}
