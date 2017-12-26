//
//  MessageList.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class MessageListReponse : Mappable {
    var data:Array<MessageItem>!
    var toastMesage:String?
    var loadMoreKey:Dictionary<String, Any>!
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        data <- map["data"]
        toastMesage <- map["toastMesage"]
        loadMoreKey <- map["loadMoreKey"]
    }
}
