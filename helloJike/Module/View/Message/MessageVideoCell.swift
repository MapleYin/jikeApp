//
//  MessageVideoCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MessageVideoCell: MessageTextCell {
    
    let videoView = MessageVideoView()
    
    override class var identifier:String {
        return "MessageVideoCell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mediaView.addSubview(videoView)
        
        videoView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(mediaView)
            make.leading.equalTo(mediaView)
            make.trailing.equalTo(mediaView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(message:Message) {
        super.setup(message: message)
        videoView.setup(message.video!)
    }

}
