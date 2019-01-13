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
    var image: Image?
    var duration:Int = 0
    var width: Int = 0
    var height: Int = 0
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        image <- map["image"]
        duration <- map["duration"]
        width <- map["width"]
        height <- map["height"]
    }
}
