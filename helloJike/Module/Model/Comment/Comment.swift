//
//  Comment.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/11.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class Comment : Mappable {
    
    enum CommentType:String {
        case messageComment = "MESSAGE_COMMENT"
        case unknown
        
        init(rawValue:String) {
            switch rawValue {
            case "MESSAGE_COMMENT":
                self = .messageComment
                break;
            default:
                self = .unknown
            }
        }
    }
    
    var type:CommentType = .unknown
    
    var commentId:String = ""
    var messageId:String = ""
    var createdAt:Date = Date()
    var content:String = ""
    
    var likes:Int = 0
    var replyCount:Int = 0
    var liked:Bool = false
    
    var pictureUrls:[Image] = []
    
    var replyToComment:Comment?
    var hotReplies:[Comment]?
    var user:User!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        commentId <- map["commentId"]
        messageId <- map["messageId"]
        createdAt <- (map["createdAt"],DefaultDateTransform())
        
        content <- map["content"]
        
        likes <- map["likes"]
        replyCount <- map["replyCount"]
        liked <- map["liked"]
        pictureUrls <- map["pictureUrls"]
        replyToComment <- map["replyToComment"]
        
        user <- map["user"]
    }
}
