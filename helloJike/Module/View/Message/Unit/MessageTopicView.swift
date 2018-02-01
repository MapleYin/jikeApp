//
//  MessageTopicView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/21.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class MessageTopicView: UIView {
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.subtitle
        
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        avatarImageView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(self)
            make.width.height.equalTo(25)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel:MessageTopicViewModel) {
        avatarImageView.kf.setImage(with: viewModel.avatarUrl)
        nameLabel.text = viewModel.topicName
    }
}
