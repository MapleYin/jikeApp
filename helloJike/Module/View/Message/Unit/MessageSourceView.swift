//
//  MessageSourceView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import AsyncDisplayKit

class MessageSourceView: ASDisplayNode ,ASNetworkImageNodeDelegate{
    var topicIconNode:ASNetworkImageNode?
    var topicNameNode:ASTextNode?
    
    var sourceUserIocnNode:ASNetworkImageNode?
    var sourceUserNameNode:ASTextNode?
    var sourceFromTextNode:ASTextNode?
    
    var sourceImageNode:ASNetworkImageNode?
    
    init(viewModel:MessageViewModel) {
        super.init()
        
        if let topic = viewModel.topic {
            topicIconNode = ASNetworkImageNode()
            topicIconNode?.cornerRadius = 5
            topicIconNode?.style.preferredSize = CGSize(width: 25, height: 25)
            topicIconNode?.url = topic.avatarUrl
            self.addSubnode(topicIconNode!)
            
            topicNameNode = ASTextNode()
            topicNameNode?.attributedText = NSAttributedString(string: topic.topicName,
                                                               attributes: [.foregroundColor : UIColor.subtitle,
                                                                            .font : UIFont.systemFont(ofSize: 12)])
            self.addSubnode(topicNameNode!)
        }
        
        if let userName = viewModel.userName {
            sourceUserIocnNode = ASNetworkImageNode()
            sourceUserIocnNode?.cornerRadius = 3
            sourceUserIocnNode?.style.preferredSize = CGSize(width: 16, height: 16)
            sourceUserIocnNode?.url = viewModel.userImageUrl
            self.addSubnode(sourceUserIocnNode!)
            
            sourceUserNameNode = ASTextNode()
            sourceUserNameNode?.attributedText = NSAttributedString(string: userName,
                                                                    attributes: [.foregroundColor : UIColor.mainBlue,
                                                                                 .font : UIFont.systemFont(ofSize: 12)])
            self.addSubnode(sourceUserNameNode!)
            
            sourceFromTextNode = ASTextNode()
            sourceFromTextNode?.attributedText = NSAttributedString(string: "来自",
                                                                    attributes: [.foregroundColor : UIColor.mute,
                                                                                 .font : UIFont.systemFont(ofSize: 12)])
            self.addSubnode(sourceFromTextNode!)
            
            
        } else if let sourceUrl = viewModel.iconImageUrl {
            sourceImageNode = ASNetworkImageNode()
            sourceImageNode?.url = sourceUrl
            sourceImageNode?.contentMode = .scaleAspectFit
            self.addSubnode(sourceImageNode!)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var layoutElement:[ASLayoutElement] = []
        if let topicIconNode = self.topicIconNode,
            let topicNameNode = self.topicNameNode {
            
            let topicLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [topicIconNode,topicNameNode])
            layoutElement.append(topicLayout)
        }
        
        if let sourceUserIocnNode = self.sourceUserIocnNode,
            let sourceUserNameNode = self.sourceUserNameNode,
            let sourceFromTextNode = self.sourceFromTextNode {
    
            let sourceUserLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [sourceFromTextNode,sourceUserIocnNode,sourceUserNameNode])
            layoutElement.append(sourceUserLayout)
        } else if let sourceImageNode = self.sourceImageNode {
            sourceImageNode.delegate = self
            layoutElement.append(sourceImageNode)
        }
        
        let layout = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: layoutElement)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11), child: layout)
    }
    
    
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage, info: ASNetworkImageNodeDidLoadInfo) {
        if self.sourceImageNode == imageNode {
            imageNode.bounds = CGRect(x: 0, y: 0, width: 12*image.size.width/image.size.height, height: 12)
        }
    }
//    - (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image info:(ASNetworkImageNodeDidLoadInfo)info
}
