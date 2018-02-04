//
//  Audio.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 "media": {
     "type": "AUDIO",
     "author": "  CHEN",
     "coverUrl": "https://media-meta.ruguoapp.com/fee7fc441a8fc96f370f543e460b2382.jpg?imageView2/0/w/200/h/200",
     "originCoverUrl": "https://media-meta.ruguoapp.com/fee7fc441a8fc96f370f543e460b2382.jpg",
     "title": "梦伴"
 }
 */

class Audio : Mappable {
    
    var author:String = ""
    var title:String = ""
    var coverUrl:String = ""
    var originCoverUrl:String = ""
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        coverUrl <- map["coverUrl"]
        originCoverUrl <- map["originCoverUrl"]
    }
}
