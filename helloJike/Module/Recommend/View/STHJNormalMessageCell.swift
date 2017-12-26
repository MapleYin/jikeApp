//
//  STHJMessageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit


class STHJNormalMessageCell: STHJTableViewCell {
    
    var containerView = UIStackView()
    var contentLabel = UILabel()
    var singleImageView = STHJMessageImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentLabel.numberOfLines = 0
        
        contentView.addSubview(containerView)
        containerView.addArrangedSubview(contentLabel)
        containerView.addArrangedSubview(singleImageView)
        
        containerView.axis = .vertical
        containerView.spacing = 25
        
        singleImageView.contentMode = .scaleAspectFill
        singleImageView.clipsToBounds = true
        singleImageView.sizeArea = CGSize(width: 200, height: 200)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(12, 12, 12, 12))
        }
        contentLabel.snp.makeConstraints { (make) in
            
        }
        singleImageView.snp.makeConstraints { (make) in

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup (_ message:Message) {
        contentLabel.text = message.content
        if let image = message.pictureUrls?.first {
            singleImageView.isHidden = false
            singleImageView.setup(image.smallPicUrl)
            singleImageView.invalidateIntrinsicContentSize()
        } else {
            singleImageView.image = nil;
            singleImageView.isHidden = true
        }
    }
    
}
