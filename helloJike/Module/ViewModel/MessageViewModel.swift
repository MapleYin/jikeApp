//
//  MessageViewModel.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/22.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation

struct MessageViewModel {
    enum CellType {
        case text,image,video
    }
    
    let type:CellType
    
    var title:String?
    var content:String?
    var images:[Image]?
    var video:Video?
    var tpoic:Topic
    
    init(message:Message) {
        tpoic = message.topic
        type = {
            if let picUrls = message.pictureUrls,
                picUrls.count > 0 {
                return .image
            } else if message.video != nil {
                return .video
            } else {
                return .text
            }
        }()
        
        title = message.content
//        content = message.
        images = message.pictureUrls
        video = message.video
    }
    
}
