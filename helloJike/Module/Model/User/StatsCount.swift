//
//  StatsCount.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

//"topicSubscribed": 23,
//"topicCreated": 0,
//"followedCount": 358,
//"followingCount": 56,
//"highlightedPersonalUpdates": 1,
//"liked": 1432

class StatsCount : Mappable {
    
    var topicSubscribed:Int = 0
    var topicCreated:Int = 0
    var followedCount:Int = 0
    var followingCount:Int = 0
    var highlightedPersonalUpdates:Int = 0
    var liked:Int = 0
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        topicSubscribed <- map["topicSubscribed"]
        topicCreated <- map["topicCreated"]
        followedCount <- map["followedCount"]
        followingCount <- map["followingCount"]
        highlightedPersonalUpdates <- map["highlightedPersonalUpdates"]
        liked <- map["liked"]
    }
}
