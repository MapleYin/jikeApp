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
    var item:Any!
    var type:String!
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        item <- (map["item"],MessageItemTransformType())
        type <- map["type"]
    }
}
