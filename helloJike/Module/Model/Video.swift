//
//  Video.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

//"type": "VIDEO",
//"thumbnailUrl": "https://media-meta.ruguoapp.com/d4f37f938eb618280be7d639dc0846ff.jpg?imageView2/0/w/800/h/800",
//"source": [],
//"duration": 210000

class Video : Mappable {
    var thumbnailUrl:String!
    var duration:Int!
    
    var durationText:String {
        let minite = duration / 60000
        let secend:Int = Int(Float(duration).truncatingRemainder(dividingBy: 60000) / 1000)
        return String(format: "%.2d:%.2d", minite,secend)
    }
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        thumbnailUrl <- map["thumbnailUrl"]
        duration <- map["duration"]
    }
}
