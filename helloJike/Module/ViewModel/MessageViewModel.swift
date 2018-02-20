//
//  MessageViewModel.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/22.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

struct MessageViewModel {
    struct MediaOptions:OptionSet{
        let rawValue: Int
        
        static let text    = MediaOptions(rawValue: 1 << 0)
        static let image   = MediaOptions(rawValue: 1 << 1)
        static let video   = MediaOptions(rawValue: 1 << 2)
        static let audio   = MediaOptions(rawValue: 1 << 3)
        
        static let imageText:MediaOptions = [.text,.image]
    }
    
    enum CellType {
        case imageText,media
    }
    
    
    var cellType:CellType = .media
    var mediaType:MediaOptions = []
    
    var title:NSAttributedString?
    var content:NSAttributedString?
    var images:[Image] = []
    var video:VideoViewModel?
    var topic:MessageTopicViewModel?
    
    var likeCountString:String = ""
    var commentCountString:String = ""
    var timeString:String = ""
    
    
    var iconImageUrl:URL?
    var userImageUrl:URL?
    var userName:String?
    
    
    init(userMessage:UserMessage) {
        self.init(message: userMessage)
        if let topic = userMessage.topics.first {
            self.topic = MessageTopicViewModel(topic)
        }
        
        self.timeString = userMessage.actionTime.messageDateString
        if let user = userMessage.users.first {
            self.userImageUrl = URL(string: user.profileImageUrl)
            self.userName = user.screenName
        }
        
    }
    
    init(feedMessage:FeedMessage) {
        
        if let message = feedMessage.personalUpdate {
            self.init(userMessage: message)
        } else {
            self.init(message: feedMessage)
        }
        
        if feedMessage.type == .article {
            cellType = .imageText
        }
        
        if let abstract = feedMessage.abstract {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.lineBreakMode = .byTruncatingTail
            
            let attributedString = NSAttributedString(string: abstract, attributes: [.paragraphStyle : paragraphStyle])
            content = attributedString
        }
        
        if let topic = feedMessage.topic {
            self.topic = MessageTopicViewModel(topic)
        }
        
        self.timeString = feedMessage.updatedAt.messageDateString
        self.iconImageUrl = URL(string: feedMessage.iconUrl)
    }
    
    init(message:Message) {
        var medias = MediaOptions()
        if message.content.count > 0 {
            medias.update(with: .text)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.lineBreakMode = .byTruncatingTail
            
            let attributedString = NSAttributedString(string: message.content, attributes: [.paragraphStyle : paragraphStyle])
            
            self.title = attributedString
        }
        if let images = message.pictureUrls,
            images.count > 0 {
            medias.update(with: .image)
            
            self.images = images
        }
        if let video = message.video {
            medias.update(with: .video)
            self.video = VideoViewModel(video)
        }
        self.mediaType = medias
        
        self.likeCountString = "\(message.likeCount)"
        self.commentCountString = "\(message.commentCount)"
    
        
    }
    
}
