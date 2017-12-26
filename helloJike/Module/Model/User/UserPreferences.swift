//
//  UserPreferences.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class UserPreferences: Mappable {
    var openMessageTabOnLaunch:Bool!
    var tabOnLaunch:String!
    var repostWithComment:Bool!
    var syncCommentToPersonalActivity:Bool!
    var env:String!
    var debugLogOn:Bool!
    var topicPushSettings:String!
    var saveDataUsageMode:Bool!
    var privateTopicSubscribe:Bool!
    var subscribeWeatherForecast:Bool!
    var followedNotificationOn:Bool!
    var dailyNotificationOn:Bool!
    var topicTagGuideOn:Bool!
    var autoPlayVideo:Bool!
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        openMessageTabOnLaunch <- map["openMessageTabOnLaunch"]
        tabOnLaunch <- map["tabOnLaunch"]
        repostWithComment <- map["repostWithComment"]
        syncCommentToPersonalActivity <- map["syncCommentToPersonalActivity"]
        env <- map["env"]
        debugLogOn <- map["debugLogOn"]
        topicPushSettings <- map["topicPushSettings"]
        saveDataUsageMode <- map["saveDataUsageMode"]
        privateTopicSubscribe <- map["privateTopicSubscribe"]
        subscribeWeatherForecast <- map["subscribeWeatherForecast"]
        followedNotificationOn <- map["followedNotificationOn"]
        dailyNotificationOn <- map["dailyNotificationOn"]
        topicTagGuideOn <- map["topicTagGuideOn"]
        autoPlayVideo <- map["autoPlayVideo"]
    }
}
