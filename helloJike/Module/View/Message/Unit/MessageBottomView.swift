//
//  MessageBottomView.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MessageBottomView: UIView {
    let containerView = UIStackView()
    
    let likeButton = UIButton(type: .custom)
    let commentButton = UIButton(type: .custom)
    let timeButton = UIButton(type: .custom)
    
    let shareButton = UIButton(type: .custom)
    
    init() {
        super.init(frame: CGRect.zero)
        
        
        likeButton.setImage(#imageLiteral(resourceName: "icon_like_normal"), for: .normal)
        likeButton.setTitle("11", for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        likeButton.setTitleColor(UIColor.title, for: .normal)
        
        commentButton.setImage(#imageLiteral(resourceName: "icon_comment"), for: .normal)
        commentButton.setTitle("11", for: .normal)
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        commentButton.setTitleColor(UIColor.title, for: .normal)
        
        timeButton.setImage(#imageLiteral(resourceName: "icon_time"), for: .normal)
        timeButton.setTitle("12:11", for: .normal)
        timeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeButton.setTitleColor(UIColor.title, for: .normal)
        
        containerView.axis = .horizontal
        containerView.spacing = 10
        containerView.addArrangedSubview(likeButton)
        containerView.addArrangedSubview(commentButton)
        containerView.addArrangedSubview(timeButton)
        
        addSubview(containerView)
        
        shareButton.setImage(#imageLiteral(resourceName: "icon_share"), for: .normal)
        addSubview(shareButton)
        
        shareButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        containerView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.centerY.equalTo(self)
        }
        shareButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        shareButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        shareButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.greaterThanOrEqualTo(containerView.snp.trailing).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.top.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
