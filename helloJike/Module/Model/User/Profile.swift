//
//  Profile.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

class Profile: Mappable {
    var user:User!
    var statsCount:StatsCount!
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        user <- map["user"]
        statsCount <- map["statsCount"]
    }
}
