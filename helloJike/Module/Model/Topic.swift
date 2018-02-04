//
//  Topic.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

/*
"id": "59f02a1ef392c60016fdf55b",
"content": "B站热门影视杂谈",
"briefIntro": "精选B站影视区每日热门杂谈视频",
"subscribersCount": 10245,
"thumbnailUrl": "https://cdn.ruguoapp.com/FqUAwHgJbCXrXz6dkvdGaIfjBmD-.png?imageView2/1/w/120/h/120/format/jpeg/q/80",
"squarePicture": {
    "thumbnailUrl": "https://cdn.ruguoapp.com/FqUAwHgJbCXrXz6dkvdGaIfjBmD-.png?imageView2/1/w/120/h/120/format/jpeg/q/80",
    "middlePicUrl": "https://cdn.ruguoapp.com/FqUAwHgJbCXrXz6dkvdGaIfjBmD-.png?imageView2/1/w/300/h/300/format/jpeg/q/80",
    "picUrl": "https://cdn.ruguoapp.com/FqUAwHgJbCXrXz6dkvdGaIfjBmD-.png?imageView2/1/h/1000/format/jpeg/interlace/0/q/80",
    "format": "jpeg"
},
"topicType": "OFFICIAL",
"isValid": true,
"operateStatus": "ONLINE",
"subscribedStatusRawValue": 0,
"updatedAt": "2017-12-23T17:18:59.458Z",
"newCategory": [9],
"ref": "NEWS_FEED_RECOMMEND_MESSAGE",
"refRemark": {
    "subtype": "热门内容"
}
*/
class Topic : Mappable {
    var id:String = ""
    var content:String = ""
    var briefIntro:String = ""
    var subscribersCount:Int = 0
    var thumbnailUrl:String = ""
    var squarePicture:Image!
    var topicType:String = ""
    var isValid:Bool = false
    var operateStatus:String = ""
    var subscribedStatusRawValue:Int = 0
    var updatedAt:Date?
    var ref:String!
    var refRemarkTitle:String!
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        briefIntro <- map["briefIntro"]
        subscribersCount <- map["subscribersCount"]
        thumbnailUrl <- map["thumbnailUrl"]
        squarePicture <- map["squarePicture"]
        topicType <- map["topicType"]
        isValid <- map["isValid"]
        operateStatus <- map["operateStatus"]
        subscribedStatusRawValue <- map["subscribedStatusRawValue"]
        updatedAt <- (map["updatedAt"],DefaultDateTransform())
        ref <- map["ref"]
        refRemarkTitle <- map["refRemark.subtype"]
    }
}

