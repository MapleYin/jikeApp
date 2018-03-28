//
//  MessageVideoNode.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import AsyncDisplayKit

class MessageVideoNode: ASDisplayNode {
    
    let imageNode = ASNetworkImageNode()
    let timeNode = ASTextNode()
    let playIconNode = ASImageNode()
    
    init(viewModel: VideoViewModel) {
        super.init()
        
        imageNode.url = viewModel.coverImageUrl
        imageNode.backgroundColor = UIColor.gray
        self.addSubnode(imageNode)
        
        timeNode.attributedText = NSAttributedString(string: viewModel.durationText,
                                                     attributes: [
                                                        .foregroundColor : UIColor.white,
                                                        .font : UIFont.systemFont(ofSize: 12)])
        self.addSubnode(timeNode)
        
        playIconNode.image = #imageLiteral(resourceName: "icon_play")
        self.addSubnode(playIconNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.flexGrow = 1
        let imageLayout = ASRatioLayoutSpec(ratio: 9.0/16.0, child: imageNode)
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), child: timeNode)
        let timeLayout = ASRelativeLayoutSpec(horizontalPosition: .end, verticalPosition: .end, sizingOption: .init(rawValue: 0), child: insetSpec)
        
        let playIconLayout = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .init(rawValue: 0), child: playIconNode)
        
        

        return ASOverlayLayoutSpec(child: imageLayout, overlay: ASWrapperLayoutSpec(layoutElements: [timeLayout,playIconLayout]))
    }
    
}
