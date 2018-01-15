//
//  MessageImageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

class MessageImageCell: MessageTextCell {
    
    override class var identifier:String {
        return "MessageImageCell"
    }
    
    let singleImageView = MessageImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        singleImageView.sizeArea = CGSize(width: 250, height: 188)
        mediaView.addSubview(singleImageView)
        
        singleImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(mediaView)
            make.leading.equalTo(mediaView).offset(11)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(message:Message) {
        super.setup(message: message)
        singleImageView.setup((message.pictureUrls?.first)!)
    }

}
