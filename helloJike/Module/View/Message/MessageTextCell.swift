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
    let bottomView = MessageBottomView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.numberOfLines = 10
        titleLabel.textColor = UIColor.title
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(mediaView)
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
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(mediaView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10).priority(.low)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(message:Message) {
        titleLabel.text = message.content
    }
}
