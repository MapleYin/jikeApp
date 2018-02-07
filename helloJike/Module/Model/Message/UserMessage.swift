//
//  UserMessage.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/23.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

class UserMessage : Message {
    
    enum ActionType:String {
        case post = "CREATE_ORIGINAL_POST"
        case repostMessage = "CREATE_REPOST"
        case repostPost = "PERSONAL_UPDATE_REPOST"
        case unknown
        
        init(rawValue:String) {
            switch rawValue {
            case "CREATE_ORIGINAL_POST":
                self = .post
                break;
            case "CREATE_REPOST":
                self = .repostMessage
                break;
            case "PERSONAL_UPDATE_REPOST":
                self = .repostPost
                break;
            default:
                self = .unknown
            }
        }
    }
    
    var action:ActionType = .unknown
    var actionTime:Date = Date()
    var topics:[Topic] = []
    var users:[User] = []
    
    
    var syncCommentId:ReplyComment?
    var message:FeedMessage?
    var repostPersonalUpdate:UserMessage?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        action <- map["action"]
        actionTime <- (map["actionTime"],DefaultDateTransform())
        
        topics <- map["topics"]
        users <- map["users"]
        
        syncCommentId <- map["syncCommentId"]
        message <- map["message"]
        repostPersonalUpdate <- map["repostPersonalUpdate"]
        
    }
    
    override func deepFetchImages() -> [Image]? {
        if let images = super.deepFetchImages(),
            images.count > 0 {
            return images
        } else if let feedMessage = self.message {
            return feedMessage.deepFetchImages()
        } else if let userMessage = self.repostPersonalUpdate {
            return userMessage.deepFetchImages()
        } else {
            return nil
        }
    }
}
