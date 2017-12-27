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
    let bottomView = MessageBottomView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 7
        containerView.addArrangedSubview(titleLabel)
        
        containerView.addArrangedSubview(bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(message:Message) {
        titleLabel.text = message.content
    }
}
