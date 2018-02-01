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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 10
        titleLabel.textColor = UIColor.title
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(mediaView)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(15)
            make.leading.equalTo(containerView).offset(11)
            make.trailing.equalTo(containerView).offset(-11)
        }
        
        mediaView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView)
        }
        
        topicView.snp.remakeConstraints { (make) in
            make.top.equalTo(mediaView.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(message:Message) {
        super.setup(message: message)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attr = NSAttributedString(string: message.content!, attributes: [.paragraphStyle : paragraphStyle])
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
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
    }
}
