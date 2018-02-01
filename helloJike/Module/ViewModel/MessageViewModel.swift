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
    
    
    let cellType:CellType
    let mediaType:MediaOptions
    
    var title:NSAttributedString?
    var content:NSAttributedString?
    let images:[Image]
    var video:VideoViewModel?
    let tpoic:MessageTopicViewModel
    
    init(message:Message) {
        
        if message.type == "article" {
            cellType = .imageText
        } else {
            cellType = .media
        }
        
        var medias = MediaOptions()
        if message.content != nil {
            medias.update(with: .text)
        }
        if let images = message.pictureUrls,
            images.count > 0 {
            medias.update(with: .image)
        }
        if message.video != nil {
           medias.update(with: .video)
        }
        mediaType = medias

        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if let content = message.content {
            let attributedString = NSAttributedString(string: content, attributes: [.paragraphStyle : paragraphStyle])
            title = attributedString
        }
        if let abstract = message.abstract {
            let attributedString = NSAttributedString(string: abstract, attributes: [.paragraphStyle : paragraphStyle])
            content = attributedString
        }
        
        
        images = message.pictureUrls ?? []
        if let video = message.video {
            self.video = VideoViewModel(video)
        }
        tpoic = MessageTopicViewModel(message.topic)
    }
    
}
