//
//  MessageTopicViewModel.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/1.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation

class MessageTopicViewModel {
    
    let topicName:String
    let avatarUrl:URL?
    
    init(_ topic:Topic) {
        topicName = topic.content
        avatarUrl = URL(string: topic.thumbnailUrl)
    }
}
