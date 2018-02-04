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
    var data:[MessageItem] = []
    var toastMesage:String?
    var loadMoreKey:[String:Any]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        data <- map["data"]
        toastMesage <- map["toastMesage"]
        loadMoreKey <- map["loadMoreKey"]
    }
}
