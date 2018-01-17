//
//  Media.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/17.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 {
 "url": "https://ups.youku.com/ups/get.json?vid=XMzMxODQyNDI0MA====&ccode=0590&client_ip=0.0.0.0&client_ts=1516063606&utid=djnkEjXr2xQCATRQieXP4jNo",
 "headers": {
 "Referer": "http://v.youku.com/v_show/id_XMzMxODQyNDI0MA====.html",
 "User-Agent": "Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Mobile Safari/537.36"
 },
 "next": "youku_next_0"
 }
 
 {
 "url": "http://pl-ali.youku.com/playlist/m3u8?vid=XMzMxODQyNDI0MA%3D%3D&type=mp4&ups_client_netip=7b760d55&ups_ts=1516063711&utid=djnkEjXr2xQCATRQieXP4jNo&ccode=0590&psid=861b4d22b3860f81afb33a50e05c464d&duration=3410&expire=18000&ups_key=e9b135d30e7f82591e4e16bb48c0add3",
 "urls": [],
 "image": "https://vthumb.ykimg.com/054101015A5B6CA1ADCA61963AE674AE",
 "duration": 3410000
 }
 
 */

class Media : Mappable {
    var url:String!
    var headers:[String : String]?
    var next:String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        url <- map["url"]
        headers <- map["headers"]
        next <- map["next"]
    }
}
