//
//  STButton.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/4.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class STButton: UIButton {
    
    /// 图片文字排列方式
    ///
    /// - LR: 左图右文
    /// - RL: 右图左文
    /// - TB: 上图下文
    /// - BT: 下图上文
    enum LayoutType {
        case LR,RL,TB,BT
    }
    
    var imageSize:CGSize = CGSize.zero
    var layout:LayoutType = .LR {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    var spacing:CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        let titleSize = titleLabel?.intrinsicContentSize ?? CGSize.zero
        let imageViewSize = imageSize.equalTo(CGSize.zero) ? (imageView?.intrinsicContentSize ?? CGSize.zero) : imageSize
        
        
        var width:CGFloat = 0
        var height:CGFloat = 0
        
        switch layout {
        case .LR,.RL:
            height = max(imageViewSize.height, titleSize.height)
            width = imageViewSize.width + titleSize.width + spacing
            break
        case .TB,.BT:
            height = imageViewSize.height + titleSize.height + spacing
            width = max(imageViewSize.width,titleSize.width)
        }
        height = height + contentEdgeInsets.top + contentEdgeInsets.bottom
        width = width + contentEdgeInsets.left + contentEdgeInsets.right
        return CGSize(width: width, height: height)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if contentRect.equalTo(CGRect.zero)  {
            return super.titleRect(forContentRect: contentRect)
        } else {
            
            var imageSize = imageView?.intrinsicContentSize ?? CGSize.zero
            if !self.imageSize.equalTo(CGSize.zero) {
                imageSize = self.imageSize
            }
            
            var titleSize = titleLabel?.intrinsicContentSize ?? CGSize.zero
            
            var x:CGFloat = 0
            var y:CGFloat = 0
            
            
            switch layout {
            case .LR,.RL:
                if titleSize.height > imageSize.height {
                    y = contentEdgeInsets.top
                } else {
                    switch contentVerticalAlignment {
                    case .top:
                        y = contentEdgeInsets.top
                        break
                    case .center:
                        y = (imageSize.height - titleSize.height) / 2
                        break
                    case .bottom:
                        y = imageSize.height - titleSize.height
                        break
                    case .fill:
                        y = contentEdgeInsets.top
                        titleSize.height = imageSize.height
                        break
                    }
                }
                break
            case .TB,.BT:
                if titleSize.width > imageSize.width {
                    x = contentEdgeInsets.left
                } else {
                    switch contentHorizontalAlignment {
                    case .left,.leading:
                        x = contentEdgeInsets.left
                        break
                    case .center:
                        x = (imageSize.width - titleSize.width) / 2
                        break
                    case .right,.trailing:
                        x = imageSize.width - titleSize.width
                        break
                    case .fill:
                        x = contentEdgeInsets.left
                        titleSize.width = imageSize.width
                        break
                    }
                }
                break
            }
            
            
            switch layout {
            case .LR:
                x = contentEdgeInsets.left + imageSize.width + spacing
                break
            case .RL:
                x = contentEdgeInsets.left
                break
            case .TB:
                y = contentEdgeInsets.top + imageSize.height + spacing
                break
            case .BT:
                y = contentEdgeInsets.top
                break
            }
            return CGRect(x: x,
                          y: y,
                          width: titleSize.width,
                          height: titleSize.height)
        }
    }
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.imageRect(forContentRect: contentRect)
        if contentRect.equalTo(CGRect.zero)  {
            return rect
        } else {
            var imageSize = rect.size
            if !self.imageSize.equalTo(CGSize.zero) {
                imageSize = self.imageSize
            }
            
            let titleSize = titleLabel?.intrinsicContentSize ?? CGSize.zero
            var x:CGFloat = 0
            var y:CGFloat = 0
            
            switch layout {
            case .LR,.RL:
                if imageSize.height > titleSize.height {
                    y = contentEdgeInsets.top
                } else {
                    switch contentVerticalAlignment {
                    case .top:
                        y = contentEdgeInsets.top
                        break
                    case .center,.fill:
                        y =  (titleSize.height - imageSize.height) / 2
                        break
                    case .bottom:
                        y = titleSize.height - imageSize.height
                        break
                    }
                }
                break
            case .TB,.BT:
                if imageSize.width > titleSize.width {
                    x = contentEdgeInsets.left
                } else {
                    switch contentHorizontalAlignment {
                    case .left,.leading:
                        x = contentEdgeInsets.left
                        break
                    case .center,.fill:
                        x = (titleSize.width - imageSize.width) / 2
                        break
                    case .right,.trailing:
                        x = titleSize.width - imageSize.width
                        break
                    }
                }
                break
            }
            
            switch layout {
            case .LR:
                x = contentEdgeInsets.left
                break
            case .RL:
                x = contentEdgeInsets.left + titleSize.width + spacing
                break
            case .TB:
                y = contentEdgeInsets.top
                break
            case .BT:
                y = contentEdgeInsets.top + titleSize.height + spacing
                break
            }
            return CGRect(x: x,
                          y: y,
                          width: imageSize.width,
                          height: imageSize.height)
        }
    }
}


