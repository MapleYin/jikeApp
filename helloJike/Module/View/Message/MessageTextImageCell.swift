//
//  MessageTextImageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

class MessageTextImageCell: MessageCell {
    
    override class var identifier:String {
        return "MessageTextImageCell"
    }
    
    let titleLabel = UILabel()
    let digestLabel = UILabel()
    let postImageView = ImageView()
    
    
    var titleConstraint:ConstraintMakerFinalizable?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.title
        
        digestLabel.font = UIFont.systemFont(ofSize: 14)
        digestLabel.numberOfLines = 2
        digestLabel.textColor = UIColor.subtitle
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(digestLabel)
        containerView.addSubview(postImageView)
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(15)
            make.leading.equalTo(containerView).offset(11)
            make.trailing.equalTo(postImageView.snp.leading).offset(-10).priority(.high)
            self.titleConstraint = make.trailing.equalTo(containerView.snp.trailing).offset(-11)
        }
        
        digestLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        digestLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel).priority(.medium)
        }
        
        postImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(containerView).offset(-11)
            make.top.equalTo(containerView).offset(15)
            make.width.height.equalTo(86)
        }
        
        topicView.snp.remakeConstraints { (make) in
            make.top.equalTo(digestLabel.snp.bottom).offset(10).priority(.high)
            make.top.greaterThanOrEqualTo(postImageView.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(viewModel: MessageViewModel) {
        super.setup(viewModel: viewModel)
        titleLabel.attributedText = viewModel.title
        digestLabel.attributedText = viewModel.content
        if let image = viewModel.images.first {
            postImageView.setImage(image)
            postImageView.isHidden = false
            self.titleConstraint?.constraint.deactivate()
        } else {
            postImageView.isHidden = true
            self.titleConstraint?.constraint.activate()
        }
    }

}
