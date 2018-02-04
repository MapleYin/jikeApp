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
    let topicView = STButton(type: .custom)
    let sourceView = MessageSourceView()
    let bottomView = MessageBottomView()
    let bottomLine = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        selectionStyle = .none
        contentView.addSubview(containerView)
        
        
        bottomLine.backgroundColor = UIColor.side
        
        topicView.imageView?.layer.cornerRadius = 5
        topicView.imageView?.clipsToBounds = true
        
        topicView.setTitleColor(UIColor.subtitle, for: .normal)
        topicView.spacing = 10
        topicView.imageSize = CGSize(width: 25, height: 25)
        topicView.titleLabel?.font = UIFont.systemFont(ofSize: 12)

        
        containerView.addSubview(topicView)
        containerView.addSubview(sourceView)
        containerView.addSubview(bottomView)
        contentView.addSubview(bottomLine)
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(contentView)
        }
        
        topicView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView).offset(10)
        }
        sourceView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        sourceView.snp.makeConstraints { (make) in
            make.centerY.equalTo(topicView)
            make.trailing.equalTo(containerView).offset(-10)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topicView.snp.bottom)
            make.leading.trailing.equalTo(containerView)
            make.height.equalTo(40)
            make.bottom.equalTo(containerView)
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
    
    func setup(viewModel: MessageViewModel) {
        if let topic = viewModel.topic {
            if let url = topic.avatarUrl {
                topicView.kf.setImage(with: url, for: .normal)
            }
            topicView.setTitle(topic.topicName , for: .normal)
        }
        
        sourceView.setup(viewModel: viewModel)
        
        bottomView.setup(likeCount: viewModel.likeCountString , commentCount: viewModel.commentCountString, time: viewModel.timeString)
    }
    
}
