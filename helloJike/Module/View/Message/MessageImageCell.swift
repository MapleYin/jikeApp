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
    
    let singleImageView = MessageImageView()
    
    override class var identifier:String {
        return "MessageImageCell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mediaView.addSubview(singleImageView)
        
        singleImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(mediaView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(message:Message) {
        super.setup(message: message)
        singleImageView.setup(message.pictureUrls!.first!)
    }

}
