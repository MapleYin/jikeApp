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
    
    let likeButton = MessageIconTextView(icon: #imageLiteral(resourceName: "icon_like_normal"))
    let commentButton = MessageIconTextView(icon: #imageLiteral(resourceName: "icon_comment"))
    let timeButton = MessageIconTextView(icon: #imageLiteral(resourceName: "icon_time"))
    
    let shareButton = UIButton(type: .custom)
    
    init() {
        super.init(frame: CGRect.zero)
        
        containerView.axis = .horizontal
        containerView.spacing = 10
        containerView.addArrangedSubview(likeButton)
        containerView.addArrangedSubview(commentButton)
        containerView.addArrangedSubview(timeButton)
        
        addSubview(containerView)
        
        shareButton.setImage(#imageLiteral(resourceName: "icon_more").withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.tintColor = UIColor.subtitle
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
    
    
    func setup(likeCount:Int,commentCount:Int,time:Date) {
        likeButton.text = String(likeCount)
        commentButton.text = String(commentCount)
        timeButton.text = time.messageDateString
    }
}
