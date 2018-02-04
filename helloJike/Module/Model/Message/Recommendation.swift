//
//  Recommendation.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class Recommendation : Mappable {
    
    enum RecommendType:String {
        case web = "web"
        case topic = "topic"
        case unknown
        
        init(rawValue:String) {
            switch rawValue {
            case "web":
                self = .web
                break
            case "topic":
                self = .topic
                break
            default:
                self = .unknown
            }
        }
    }
    
    
    var id:String = ""
    var type:RecommendType = .unknown
    var url:String = ""
    var picUrl:String = ""
    var tag:String = ""
    var title:String = ""
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        url <- map["url"]
        picUrl <- map["picUrl"]
        tag <- map["tag"]
        title <- map["title"]
    }
}
