//
//  MessageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MessageCell: ASCellNode {
    var messageModel:MessageViewModel
    let titleLable = ASTextNode2()
    let digestLabel = ASTextNode2()
    let imageNode = ASNetworkImageNode()
    let messageSourceNode:MessageSourceView
    
    var videoNode:MessageVideoNode?
    
    var mutipleImage:MessageImageNode?
    
    init(messageModel:MessageViewModel) {
        self.messageModel = messageModel
        self.messageSourceNode = MessageSourceView(viewModel: messageModel)
        super.init()
        
        if let titleString = messageModel.title {
            titleLable.attributedText = titleString
            titleLable.maximumNumberOfLines = messageModel.cellType == .imageText ? 3 : 10
            self.addSubnode(titleLable)
        }
        
        if let digest = messageModel.content {
            digestLabel.attributedText = digest
            digestLabel.maximumNumberOfLines = 3
            self.addSubnode(digestLabel)
        }
        
        if messageModel.cellType == .imageText,
            messageModel.images.count > 0,
            let image = messageModel.images.first,
            let imageUrl = URL(string: image.smallPicUrl) {
            
            imageNode.style.preferredSize = CGSize(width: 86, height: 86)
            imageNode.url = imageUrl
            self.addSubnode(imageNode)
        } else if messageModel.images.count > 0 {
            mutipleImage = MessageImageNode(imageList: messageModel.images)
            self.addSubnode(mutipleImage!)
        }
        
        if let video = messageModel.video {
            self.videoNode = MessageVideoNode(viewModel: video)
            self.addSubnode(self.videoNode!)
        }
        
        self.addSubnode(self.messageSourceNode)
        
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        var verticalLayoutList = [ASLayoutElement]()
        
        if messageModel.cellType == .imageText {
            // MARK: - Article
            
            var verticalNodeList = [ASDisplayNode]()
            
            if messageModel.title != nil {
                verticalNodeList.append(titleLable)
            }
            
            if messageModel.content != nil {
                verticalNodeList.append(digestLabel)
            }
            
            let verticalLayout = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 10,
                                                   justifyContent: .start,
                                                   alignItems: .start,
                                                   children: verticalNodeList)
            
        
            verticalLayout.style.flexShrink = 1
            
            var horizontalNodeList:[ASLayoutElement] = [verticalLayout]
            
            if self.messageModel.images.count > 0 {
                horizontalNodeList.append(imageNode)
            }
            
            let horizontalLayout = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 10,
                                                     justifyContent: .spaceBetween,
                                                     alignItems: .start,
                                                     children: horizontalNodeList)
            let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11),
                                                child: horizontalLayout)
            
            verticalLayoutList.append(insetLayout)
  
        } else {
            // MARK: - Media
            
            if messageModel.title != nil {
                let titleLayout = ASInsetLayoutSpec(insets:  UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11) ,
                                                    child: titleLable)
                verticalLayoutList.append(titleLayout)
            }
            
            if let mutipleImage = self.mutipleImage {
                verticalLayoutList.append(mutipleImage)
            }
            
            if let videoNode = self.videoNode {
                verticalLayoutList.append(videoNode)
            }
            
        }
        
        
        messageSourceNode.style.spacingBefore = 5
        verticalLayoutList.append(messageSourceNode)
        
        let verticalLayout = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: verticalLayoutList)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0), child: verticalLayout)
        
    }
}
