//
//  MessageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

protocol MessageCellAction:class {
    
}

class MessageCell: BaseCell {
    
    override class var identifier:String {
        return "MessageCell"
    }

    let containerView = UIView()
    let topicView = MessageTopicView()
    let iconImageView = UIImageView()
    let bottomView = MessageBottomView()
    let bottomLine = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        selectionStyle = .none
        contentView.addSubview(containerView)
        
        iconImageView.contentMode = .scaleAspectFit
        bottomLine.backgroundColor = UIColor.side
        
        containerView.addSubview(topicView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(bottomView)
        contentView.addSubview(bottomLine)
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(contentView)
        }
        
        topicView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView).offset(10)
        }
        iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(topicView)
            make.trailing.equalTo(containerView).offset(-10)
            make.height.equalTo(12)
            make.width.equalTo(20)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topicView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView)
            make.bottom.equalTo(containerView).offset(-10)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom)
            make.height.equalTo(5)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom).priority(.low)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            containerView.backgroundColor = UIColor.line
        } else {
            containerView.backgroundColor = UIColor.clear
        }
    }
    
    func setup(message:Message) {
        topicView.setup(topic: message.topic)
        bottomView.setup(likeCount: message.likeCount, commentCount: message.commentCount, time: message.createdAt)
    }
    
}
