//
//  MessageItem.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class MessageItem : Mappable {
    
    enum itemType: String {
        case topRecommend = "HEADLINE_RECOMMENDATION"
        case messageRecommend = "RECOMMENDED_MESSAGE"
        case personalUpdate = "PERSONAL_UPDATE"
        case backToTop = "BACK_TO_TOP"
        case daily = "DAILY"
        
        case popular = "POPULAR_MESSAGE"
        case message = "MESSAGE"
        
        case unknown
        
        init(rawValue:String) {
            switch rawValue {
            case "HEADLINE_RECOMMENDATION":
                self = .topRecommend
                break
            case "RECOMMENDED_MESSAGE":
                self = .messageRecommend
                break
            case "PERSONAL_UPDATE":
                self = .personalUpdate
                break
            case "BACK_TO_TOP":
                self = .backToTop
                break
            case "DAILY":
                self = .daily
                break
            case "POPULAR_MESSAGE":
                self = .popular
                break
            case "MESSAGE":
                self = .message
                break
            default:
                self = .unknown
            }
        }
    }
    
    var item: Any?
    var type: itemType = .unknown
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        type <- map["type"]
        item <- (map["item"], MessageItemTransformType(type))
    }
}
