//
//  MessageMultipleImageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MessageMultipleImageCell: MessageTextCell {
    
    let multipleImageView = MessageMultipleImageView()
    
    override class var identifier:String {
        return "MessageMultipleImageCell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let index = containerView.arrangedSubviews.index(of: titleLabel) {
            containerView.insertArrangedSubview(multipleImageView, at: index + 1)
        } else {
            containerView.addArrangedSubview(multipleImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setup(message:Message) {
        super.setup(message: message)
        multipleImageView.setup(message.pictureUrls!)
    }
}
