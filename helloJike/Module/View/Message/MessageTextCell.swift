//
//  MessageTextCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

class MessageTextCell: MessageCell {
    
    override class var identifier:String {
        return "MessageTextCell"
    }
    
    let titleLabel = UILabel()
    let mediaView = UIView()
    let topicView = MessageTopicView()
    let iconImageView = UIImageView()
    let bottomView = MessageBottomView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 10
        titleLabel.textColor = UIColor.title
        
        iconImageView.contentMode = .scaleAspectFit
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(mediaView)
        containerView.addSubview(topicView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(bottomView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(10)
            make.leading.equalTo(containerView).offset(11)
            make.trailing.equalTo(containerView).offset(-11)
        }
        
        mediaView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView)
        }
        
        topicView.snp.makeConstraints { (make) in
            make.top.equalTo(mediaView.snp.bottom).offset(10)
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
            make.bottom.equalTo(containerView.snp.bottom).offset(-10).priority(.low)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(message:Message) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attr = NSAttributedString(string: message.content, attributes: [.paragraphStyle : paragraphStyle])
        titleLabel.attributedText = attr
        if let urlString = message.iconUrl,
            let url = URL(string: urlString) {
            iconImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                if let image = image {
                    self.iconImageView.snp.updateConstraints({ (make) in
                        make.width.equalTo(image.size.width/image.size.height*12)
                    })
                }
            })
        }
        topicView.setup(topic: message.topic)
        bottomView.setup(likeCount: message.likeCount, commentCount: message.commentCount, time: message.createdAt)
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
    }
}
