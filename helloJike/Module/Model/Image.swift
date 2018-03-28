//
//  Image.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

//{
//    "thumbnailUrl": "https://cdn.ruguoapp.com/27edb84ad1414b645571378d69f2b11a?imageView2/0/w/2000/h/300/q/30",
//    "smallPicUrl": "https://cdn.ruguoapp.com/27edb84ad1414b645571378d69f2b11a?imageView2/0/w/2000/h/400/q/30",
//    "middlePicUrl": "https://cdn.ruguoapp.com/27edb84ad1414b645571378d69f2b11a?imageView2/0/h/600/interlace/1/q/30",
//    "picUrl": "https://cdn.ruguoapp.com/27edb84ad1414b645571378d69f2b11a?imageView2/0/h/2000/interlace/1",
//    "cropperPosX": 0.5,
//    "cropperPosY": 0.5,
//    "format": "jpeg",
//    "width": 840,
//    "height": 473
//}

class Image : Mappable {
    var thumbnailUrl:String!
    var smallPicUrl:String!
    var middlePicUrl:String!
    var picUrl:String!
    var cropperPosX:CGFloat!
    var cropperPosY:CGFloat!
    var width:CGFloat!
    var height:CGFloat!
    var format:String!
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        thumbnailUrl <- map["thumbnailUrl"]
        smallPicUrl <- map["smallPicUrl"]
        middlePicUrl <- map["middlePicUrl"]
        picUrl <- map["picUrl"]
        cropperPosX <- map["cropperPosX"]
        cropperPosY <- map["cropperPosY"]
        width <- map["width"]
        height <- map["height"]
        format <- map["format"]
    }
    
    func urls() -> [URL] {
        var urls = [URL]()
//        if let url = URL(string: thumbnailUrl) {
//            urls.append(url)
//        }
//
//        if let url = URL(string: smallPicUrl) {
//            urls.append(url)
//        }
        
        if let url = URL(string: middlePicUrl) {
            urls.append(url)
        }
        
//        if let url = URL(string: picUrl) {
//            urls.append(url)
//        }
        
        return urls
    }
    
    func cropRect() -> CGRect {
        return CGRect(x: cropperPosX, y: cropperPosY, width: 0, height: 0)
    }
}
