//
//  MessageTopicViewModel.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/1.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation

class MessageTopicViewModel {
    
    let topicName:  String
    var avatarUrl: URL?
    
    init(_ topic:Topic) {
        topicName = topic.content
        if let url = topic.squarePicture?.thumbnailUrl {
            avatarUrl = URL(string: url)
        }
    }
}
