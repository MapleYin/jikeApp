//
//  Link.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 "linkInfo": {
     "type": "VIDEO",
     "pictureUrl": "https://media-meta.ruguoapp.com/548a126ad9e1c55650100fc3049327b5.jpg",
     "title": "http://onetake.dafork.com/static/photos/4kzkez8.html",
     "link": "http://onetake.dafork.com/static/photos/4kzkez8.html"
 }
 
 "linkInfo": {
     "type": "AUDIO",
     "pictureUrl": "https://media-meta.ruguoapp.com/3e76b75066986bc4dfaa56fefed49064.jpg",
     "title": "xxxxxxxxxxxl - City Of Stars",
     "link": "http://kg3.qq.com/node/play?s=6yP2FE6JNYLCJ6HO&shareuid=609899872528338d31&topsource=a0_pn201001006_z11_u254205465_l1_t1517569793__"
 }
 */


class Link : Mappable {
    enum LinkType:String {
        case video = "VIDEO"
        case audio = "AUDIO"
        case unkonwn
        
        init(rawValue:String) {
            switch rawValue {
            case "VIDEO":
                self = .video
                break;
            case "AUDIO":
                self = .audio
                break;
            default:
                self = .unkonwn
            }
        }
    }
    
    var type:LinkType = .unkonwn
    var title:String = ""
    var link:String = ""
    var pictureUrl:String = ""

    
    
    required init?(map: Map){
        
    }
    
    
    func mapping(map: Map) {
        type <- map["type"]
        title <- map["title"]
        link <- map["link"]
        pictureUrl <- map["pictureUrl"]
    }
}
