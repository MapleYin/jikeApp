//
//  MessageImageNode.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/27.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MessageImageNode : ASDisplayNode {
    
    private var imageNodeList = [ASNetworkImageNode]()
    private let imageList:[Image]
    
    init(imageList:[Image]) {
        self.imageList = imageList
        super.init()
        
        imageList.forEach { (image) in
            let imageNode = ASNetworkImageNode()
            imageNode.cropRect = image.cropRect()
            imageNode.backgroundColor = UIColor.gray
            imageNode.urls = image.urls()
            imageNode.shouldRenderProgressImages = false
            self.imageNodeList.append(imageNode)
            self.addSubnode(imageNode)
        }
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        var layout:[ASLayoutElement] = []
        
        // first line
        let firstLineLayout:ASLayoutElement
        switch imageNodeList.count {
        case 4,7:
            let imageLayout = ASRatioLayoutSpec(ratio: 0.5, child: imageNodeList.first!)
            imageLayout.style.flexGrow = 1
            firstLineLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .start, alignItems: .start, children: [imageLayout])
            break;
        case 2,5,8:
            var imageLayout:[ASLayoutElement] = []
            Array(imageNodeList[0..<2]).forEach({ (imageNode) in
                let ratioLayout = ASRatioLayoutSpec(ratio: 1, child: imageNode)
                ratioLayout.style.flexGrow = 1
                imageLayout.append(ratioLayout)
            })
            firstLineLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .start, alignItems: .start, children: imageLayout)
            break;
        case 3,6,9:
            var imageLayout:[ASLayoutElement] = []
            Array(imageNodeList[0..<3]).forEach({ (imageNode) in
                let ratioLayout = ASRatioLayoutSpec(ratio: 1, child: imageNode)
                ratioLayout.style.flexGrow = 1
                imageLayout.append(ratioLayout)
            })
            firstLineLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .start, alignItems: .start, children: imageLayout)
            break;
        default:
            let image = imageList[0]
            let imageNode = imageNodeList[0]
            firstLineLayout = ASRatioLayoutSpec(ratio: image.height/image.width, child: imageNode)
            firstLineLayout.style.maxHeight = ASDimensionMake(500)
        }
        
        layout.append(firstLineLayout)
        
        // second
        if imageNodeList.count > 3 {
            var imageList:[ASNetworkImageNode] = []
            switch imageNodeList.count {
            case 4,7:
                imageList = Array(imageNodeList[1..<4])
                break;
            case 5,8:
                imageList = Array(imageNodeList[2..<5])
                break;
            case 6,9:
                imageList = Array(imageNodeList[3..<6])
                break;
            default: break
                
            }
            
            var imageLayout:[ASLayoutElement] = []
            imageList.forEach({ (imageNode) in
                let ratioLayout = ASRatioLayoutSpec(ratio: 1, child: imageNode)
                ratioLayout.style.flexGrow = 1
                imageLayout.append(ratioLayout)
            })
            
            let secondLineLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .start, alignItems: .start, children: imageLayout)
            layout.append(secondLineLayout)
        }
        
        // third
        if imageNodeList.count > 6 {
            let imageList = Array(imageNodeList[(imageNodeList.count-3)..<imageNodeList.count])
            
            var imageLayout:[ASLayoutElement] = []
            imageList.forEach({ (imageNode) in
                let ratioLayout = ASRatioLayoutSpec(ratio: 1, child: imageNode)
                ratioLayout.style.flexGrow = 1
                imageLayout.append(ratioLayout)
            })
            
            let thirdLineLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .start, alignItems: .start, children: imageLayout)
            layout.append(thirdLineLayout)
        }
        
        return ASStackLayoutSpec(direction: .vertical, spacing: 3, justifyContent: .start, alignItems: .stretch, children: layout)
    }
}
