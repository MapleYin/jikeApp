//
//  ReplyComment.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class ReplyComment : Mappable {
    
    var commentId:String = ""
    var content:String = ""
    var pictureUrls:[Image] = []
    var user : User?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        commentId <- map["commentId"]
        content <- map["content"]
        pictureUrls <- map["pictureUrls"]
        user <- map["user"]
    }
}
