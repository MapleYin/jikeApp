//
//  MessageImageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MessageImageCell: MessageTextCell {
    
    override class var identifier:String {
        return "MessageImageCell"
    }
    
    let singleImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let index = containerView.index(ofAccessibilityElement: titleLabel)
        containerView.insertArrangedSubview(singleImageView, at: index)

        
    }
}
