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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        containerView.addArrangedSubview(titleLabel)
        
        containerView.addArrangedSubview(bottomView)
    }

}
