//
//  CommentListResponse.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/13.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class CommentListResponse : Mappable {
    
    var hasMoreHotComments:Bool = false
    var hotComments:[Comment] = []
    var data:[Comment] = []
    var loadMoreKey:[String:Any]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        hasMoreHotComments <- map["hasMoreHotComments"]
        hotComments <- map["hotComments"]
        data <- map["data"]
        loadMoreKey <- map["loadMoreKey"]
    }
    
    
}
