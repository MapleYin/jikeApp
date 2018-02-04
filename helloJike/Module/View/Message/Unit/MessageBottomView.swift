//
//  MessageBottomView.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

// item
extension STButton {
    func setupMessageBottomIconButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        spacing = 5
        tintColor = UIColor.mute
    }
}


class MessageBottomView: UIView {
    let containerView = UIStackView()
    
    let likeButton = STButton(type: .system)
    let commentButton = STButton(type: .system)
    let timeButton = STButton(type: .system)
    
    let shareButton = UIButton(type: .custom)
    
    init() {
        super.init(frame: CGRect.zero)
        
        containerView.axis = .horizontal
        containerView.spacing = 20
        containerView.alignment = .center
        containerView.addArrangedSubview(likeButton)
        containerView.addArrangedSubview(commentButton)
        containerView.addArrangedSubview(timeButton)
        
        addSubview(containerView)
        
        likeButton.setImage(#imageLiteral(resourceName: "icon_like_normal"), for: .normal)
        likeButton.setupMessageBottomIconButton()
        commentButton.setImage(#imageLiteral(resourceName: "icon_comment"), for: .normal)
        commentButton.setupMessageBottomIconButton()
        timeButton.setImage(#imageLiteral(resourceName: "icon_time"), for: .normal)
        timeButton.setupMessageBottomIconButton()
        timeButton.isUserInteractionEnabled = false
        
        shareButton.setImage(#imageLiteral(resourceName: "icon_more").withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.tintColor = UIColor.subtitle
        addSubview(shareButton)
        
        
        containerView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(self)
        }
        shareButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        shareButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        shareButton.snp.makeConstraints { (make) in
            make.leading.greaterThanOrEqualTo(containerView.snp.trailing).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(likeCount:String,commentCount:String,time:String) {
        likeButton.setTitle(likeCount, for: .normal)
        commentButton.setTitle(commentCount, for: .normal)
        timeButton.setTitle(time, for: .normal)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let inside = self.shareButton.frame.contains(point)
        if inside {
            return self.shareButton
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    
}
